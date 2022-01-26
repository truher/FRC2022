from __future__ import annotations
from typing import List, Optional, Tuple
import numpy as np
from mesa import Agent # type:ignore
#from numpy.typing import NDArray
from .alliance import Alliance
from .collision import collide, collide_pos, overlap

R3 = Tuple[float, float, float]
RN = List[float] # fix this with pep646 when 3.11 comes out

# TODO: do this differently
X_MAX_M = 16.46
Y_MAX_M = 8.23
CENTER: R3 = (X_MAX_M/2, Y_MAX_M/2, 0)


# height (energy) recovered is ~0.75 so velocity is ~0.85.
# i think this is quite different from the horizontal case because the ball is spinning
# and scuffs against the wall, which consumes ~all the angular momentum.
VERTICAL_ELASTICITY = 0.85

END_WALL_HEIGHT_M = 1.97
SIDE_WALL_HEIGHT_M = 0.51

GRAVITY_M_S_S = 9.8
# measured with video and a few papers
# http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.311.2690&rep=rep1&type=pdf
# https://www.resna.org/sites/default/files/conference/2018/wheelchair_seating/Dickey.html
# https://archive.thepocketlab.com/educators/lesson/rolling-resistance-physics-lab
ROLLING_FRICTION_COEFFICIENT = 0.0135

class Thing(Agent): # type:ignore
    def __init__(self, unique_id: int, model: 'Model', # type: ignore
        pos: R3, elasticity: float
    ) -> None:
        super().__init__(unique_id, model)
        # TODO: remove pos, place_agent does it.
        self._pos: RN = [0, 0, 0] # pos in meters, mutable
        self._pos[0] = pos[0]
        self._pos[1] = pos[1]
        self._pos[2] = pos[2]
        self.radius_m: float = 0
        self.mass_kg: float = 0
        self.elasticity = elasticity
        self._velocity: RN = [0, 0, 0] # velocity in m/s, mutable

    @property
    def pos(self) -> R3:
        if self._pos is None:
            return None
        return (self._pos[0], self._pos[1], self._pos[2])

    @pos.setter
    def pos(self, value: R3) -> None:
        if value is None:
            self._pos = None
            return
        if self._pos is None:
            self._pos = [0, 0, 0]
        self._pos[0] = value[0]
        self._pos[1] = value[1]
        self._pos[2] = value[2]

    @property
    def velocity(self) -> R3:
        if self._velocity is None:
            return None
        return (self._velocity[0], self._velocity[1], self._velocity[2])

    @velocity.setter
    def velocity(self, value: R3) -> None:
        if value is None:
            self._velocity = None
            return
        if self._velocity is None:
            self._velocity = [0, 0, 0]
        self._velocity[0] = value[0]
        self._velocity[1] = value[1]
        self._velocity[2] = value[2]

    @property
    def speed(self) -> np.float64:
        return np.linalg.norm(self.velocity)

    def update_pos_for_velocity(self, size_x: float, size_y: float) -> None:
        if self._pos is None:
            # we're in some delay somewhere
            return
        dv0 = self._velocity[0] * self.model.seconds_per_step
        dv1 = self._velocity[1] * self.model.seconds_per_step
        dv2 = self._velocity[2] * self.model.seconds_per_step

        self._pos[0] += dv0
        self._pos[1] += dv1
        self._pos[2] += dv2

        # TODO: replace these collisions with real ones
        if self._pos[0] <= self.radius_m:
            self._pos[0] = self.radius_m
        elif self._pos[0] >= (x2_bound := (size_x - self.radius_m)):
            self._pos[0] = x2_bound

        if self._pos[1] <= self.radius_m:
            self._pos[1] = self.radius_m
        elif self._pos[1] >= (y2_bound := (size_y - self.radius_m)):
            self._pos[1] = y2_bound

        if self._pos[2] < 0:
            self._velocity[2] = -self._velocity[2] * VERTICAL_ELASTICITY
            self._pos[2] = 0

        self.model.space.move_agent(self, self._pos)

    def is_colliding(self, other: Thing) -> bool:
        return overlap(other.pos, self.pos, other.radius_m, self.radius_m)

    def check_wall_collision(self, size_x: float, size_y: float) -> None:
        out = False
        if self._pos[0] <= self.radius_m:
            # blue wall 197cm high
            if self._pos[2] > END_WALL_HEIGHT_M:
                out = True
            self._pos[0] = self.radius_m
            self._velocity[0] = -self._velocity[0] * self.elasticity
        elif self._pos[0] >= (x2_bound := (size_x - self.radius_m)):
            # red wall 197cm high
            if self._pos[2] > END_WALL_HEIGHT_M:
                out = True
            self._pos[0] = x2_bound
            self._velocity[0] = -self._velocity[0] * self.elasticity
        if self._pos[1] <= self.radius_m:
            # side wall 51cm high
            if self._pos[2] > SIDE_WALL_HEIGHT_M:
                out = True
            self._pos[1] = self.radius_m
            self._velocity[1] = -self._velocity[1] * self.elasticity
        elif self._pos[1] >= (y2_bound := (size_y - self.radius_m)):
            # side wall 51cm high
            if self._pos[2] > SIDE_WALL_HEIGHT_M:
                out = True
            self._pos[1] = y2_bound
            self._velocity[1] = -self._velocity[1] * self.elasticity
        if out:
            print(f"{self.unique_id} out {self._pos}")
            self.model.space.remove_agent(self)
            self.model.schedule.remove(self)
            self.model.out_of_bounds.put(self, self.model.model_time)
            return
        # bounce off the floor
        if self._pos[2] < 0:
            self._pos[2] = 0
            self._velocity[2] = -self._velocity[2] * VERTICAL_ELASTICITY

    def check_ball_collision(self, other: Thing) -> bool: # if actually colliding
        if isinstance(self, Obstacle) and isinstance(other, Obstacle):
            return False
        if not self.is_colliding(other):
            return False
        # balls above robots don't collide (with each other either)
        # TODO: handle the hub case separately
        if self.pos[2] > 1.32 or other.pos[2] > 1.32:
            return False
        selfv, otherv = collide(
            self.pos, self.velocity, self.mass_kg, self.elasticity,
            other.pos, other.velocity, other.mass_kg, other.elasticity)
        self.velocity = selfv
        other.velocity = otherv
        selfp, otherp = collide_pos(
            self.pos, self.mass_kg, self.radius_m,
            other.pos, other.mass_kg, other.radius_m)
        self.pos = selfp
        other.pos = otherp
        return True

# TODO: lower height too, for upper hub
class Obstacle(Thing):
    """ has infinite mass """
    def __init__(self, unique_id: int, model: 'Model', # type: ignore
        pos: R3, radius_m: float, z_height_m: float
    ) -> None:
        super().__init__(unique_id, model, pos, 1.0)
        #self.pos = pos
        #self.radius_m = 0.045 # terminal posts are  ~4.5cm wide
        self.radius_m = radius_m
        self.mass_kg = np.inf
        self.z_height_m = z_height_m
        self.z_altitude_m = 0 # off the floor

    def step(self) -> None: # override: never moves, so just check collisions
        for other in self.model.space.get_neighbors(self.pos, 4, False): # 2m neighborhood
            if self.unique_id >= other.unique_id:
                continue
            self.check_ball_collision(other)

class Cargo(Thing):
    def __init__(self, unique_id: int, model: 'Model', # type: ignore
        pos: R3, alliance: Alliance,
    ) -> None:
        super().__init__(unique_id, model, pos, 0.5) # elasticity 0.5
        # i measured elasticity of 0.5 for rolling collisions, using video
        self.alliance: Alliance = alliance
        self.radius_m = 0.12
        self.mass_kg = 0.27

    def update_velocity_for_rolling_friction(self) -> None:
        # balls in the air aren't affected by rolling friction
        if self._pos[2] > 0.01:
            return
        accel = GRAVITY_M_S_S * ROLLING_FRICTION_COEFFICIENT
        dv = accel * self.model.seconds_per_step # delta v during this step
        v_scalar = np.linalg.norm(self.velocity)
        if dv > v_scalar:
            self.velocity = (0, 0, 0)
        else:
            v_ratio = dv / v_scalar
            self.velocity = np.multiply(self.velocity, 1-v_ratio)

    # TODO: also air resistance
    def update_v_z_for_gravity(self) -> None:
        self._velocity[2] -= GRAVITY_M_S_S * self.model.seconds_per_step

    def step(self) -> None:
        collided = False # don't try to apply any other forces in collisions
        for other in self.model.space.get_neighbors(self.pos, 2, False): # 2m neighborhood
            if self.unique_id >= other.unique_id:
                continue
            if self.check_ball_collision(other):
                collided = True
        if not collided:
            self.update_velocity_for_rolling_friction()
            self.update_v_z_for_gravity()
        # do this regardless because walls are absolute
        self.check_wall_collision(X_MAX_M, Y_MAX_M)
        self.update_pos_for_velocity(X_MAX_M, Y_MAX_M)

class Robot(Thing):
    def __init__(self, unique_id: int, model: 'Model', # type: ignore
        pos: R3, alliance: Alliance,
    ):
        super().__init__(unique_id, model, pos, 0.1)
        # seems like robot collisions are *really* inelastic
        self.radius_m: float = 0.50
        self.mass_kg: float = 56 # max allowed
        self.alliance: Alliance = alliance
        self.slot1: Optional[Cargo] = None # TODO: just make this a list
        self.slot2: Optional[Cargo] = None

    # override
    @property
    def pos(self) -> R3:
        if self._pos is None:
            return None
        return (self._pos[0], self._pos[1], self.radius_m)

    # override
    @pos.setter
    def pos(self, value: R3) -> None:
        if value is None:
            self._pos = None
            return
        if self._pos is None:
            self._pos = [0, 0, 0]
        self._pos[0] = value[0]
        self._pos[1] = value[1]
        self._pos[2] = self.radius_m

    @property
    def velocity(self) -> R3:
        if self._velocity is None:
            return None
        return (self._velocity[0], self._velocity[1], 0)

    @velocity.setter
    def velocity(self, value: R3) -> None:
        if value is None:
            self._velocity = None
            return
        if self._velocity is None:
            self._velocity = [0, 0, 0]
        self._velocity[0] = value[0]
        self._velocity[1] = value[1]
        self._velocity[2] = 0


    def step(self) -> None:
        # pick up nearby balls TODO: make this a process that takes time
        for item in self.model.space.get_neighbors(self.pos, 0.75, False):
            if isinstance(item, Cargo):
                # can only pick up balls that are close to the floor
                if item.pos[2] > 0.4:
                    continue
                if self.slot1 is None:
                    self.slot1 = item
                    self.model.space.remove_agent(item)
                    self.model.schedule.remove(item)
                    break
                if self.slot2 is None:
                    self.slot2 = item
                    self.model.space.remove_agent(item)
                    self.model.schedule.remove(item)
                    break
                break # no space, stop iterating

        # shoot balls randomly
        # TODO: make this take time
        # TODO: pay attention to color
        # TODO: altitude
        # TODO: shot velocity depends on distance
        if self.slot1 is not None or self.slot2 is not None:
            to_center_v = np.subtract(CENTER, self.pos)
            to_center_dir = np.divide(to_center_v, np.linalg.norm(to_center_v))
            velocity = np.multiply(12, to_center_dir) # 12 m/s towards the middle
            newpos = np.add(np.multiply(self.radius_m + 0.14, to_center_dir), self.pos)
        if self.slot1 is not None:
            self.slot1.velocity = velocity
            self.slot1._velocity[2] = 7 # TODO: ballistics
            self.model.space.place_agent(self.slot1, newpos)
            self.model.schedule.add(self.slot1)
            self.slot1 = None
        elif self.slot2 is not None:
            self.slot2.velocity = velocity
            self.slot2._velocity[2] = 7 # TODO: ballistics
            self.model.space.place_agent(self.slot2, newpos)
            self.model.schedule.add(self.slot2)
            self.slot2 = None

        collided = False # don't try to apply any other forces in collisions
        for other in self.model.space.get_neighbors(self.pos, 4, False): # 4m neighborhood
            if self.unique_id >= other.unique_id:
                continue
            if self.check_ball_collision(other):
                collided = True
        if not collided:
            v = np.random.normal(loc=0.00, scale=0.05, size=2)
            self._velocity[0] += v[0]
            self._velocity[1] += v[1]
        self.check_wall_collision(X_MAX_M, Y_MAX_M)
        self.update_pos_for_velocity(X_MAX_M, Y_MAX_M)
