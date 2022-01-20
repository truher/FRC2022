from __future__ import annotations
from typing import Optional
import numpy as np
from mesa import Agent # type:ignore
from numpy.typing import NDArray
from .alliance import Alliance
from .collision import collide, collide_pos, overlap

# TODO: do this differently
X_MAX_M = 16.46
Y_MAX_M = 8.23
CENTER: NDArray[np.float64] = np.array((X_MAX_M/2, Y_MAX_M/2))


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
        pos, elasticity
    ) -> None:
        super().__init__(unique_id, model)
        self.pos = pos # TODO: remove this, place_agent does it.
        self.radius_m: float = 0
        self.mass_kg: float = 0
        self.elasticity = elasticity
        self.velocity: NDArray[np.float64] = np.zeros(2)
        self.z_m: float = 0
        self.vz_m_s: float = 0

    @property
    def speed(self) -> np.float64:
        return np.linalg.norm(self.velocity)

    def update_pos_for_velocity(self, size_x: float, size_y: float) -> None:
        if self.pos is None:
            # we're in some delay somewhere
            return
        self.pos += self.velocity * self.model.seconds_per_step
        if self.pos[0] <= self.radius_m:
            self.pos[0] = self.radius_m
        elif self.pos[0] >= (x2_bound := (size_x - self.radius_m)):
            self.pos[0] = x2_bound
        if self.pos[1] <= self.radius_m:
            self.pos[1] = self.radius_m
        elif self.pos[1] >= (y2_bound := (size_y - self.radius_m)):
            self.pos[1] = y2_bound
        self.model.space.move_agent(self, self.pos)
        # update z
        self.z_m += self.vz_m_s * self.model.seconds_per_step
        # don't go through the floor
        if self.z_m < 0:
            self.vz_m_s = -self.vz_m_s * VERTICAL_ELASTICITY
            self.z_m = 0

    def is_colliding(self, other: Thing) -> bool:
        return overlap(other.pos, self.pos, other.radius_m, self.radius_m)

    def check_wall_collision(self, size_x: float, size_y: float) -> None:
        out = False
        if self.pos[0] <= self.radius_m:
            # blue wall 197cm high
            if self.z_m > END_WALL_HEIGHT_M:
                out = True
            self.pos[0] = self.radius_m
            self.velocity[0] = -self.velocity[0] * self.elasticity
        elif self.pos[0] >= (x2_bound := (size_x - self.radius_m)):
            # red wall 197cm high
            if self.z_m > END_WALL_HEIGHT_M:
                out = True
            self.pos[0] = x2_bound
            self.velocity[0] = -self.velocity[0] * self.elasticity
        if self.pos[1] <= self.radius_m:
            # side wall 51cm high
            if self.z_m > SIDE_WALL_HEIGHT_M:
                out = True
            self.pos[1] = self.radius_m
            self.velocity[1] = -self.velocity[1] * self.elasticity
        elif self.pos[1] >= (y2_bound := (size_y - self.radius_m)):
            # side wall 51cm high
            if self.z_m > SIDE_WALL_HEIGHT_M:
                out = True
            self.pos[1] = y2_bound
            self.velocity[1] = -self.velocity[1] * self.elasticity
        if out:
            self.model.space.remove_agent(self)
            self.model.schedule.remove(self)
            self.model.out_of_bounds.put(self, self.model.model_time)
            return
        # bounce off the floor
        if self.z_m < 0:
            self.z_m = 0
            self.vz_m_s = -self.vz_m_s * VERTICAL_ELASTICITY

    def check_ball_collision(self, other: Thing) -> bool: # if actually colliding
        if isinstance(self, Obstacle) and isinstance(other, Obstacle):
            return False
        if not self.is_colliding(other):
            return False
        # balls above robots don't collide (with each other either)
        # TODO: handle the hub case separately
        if self.z_m > 1.32 or other.z_m > 1.32:
            return False
        self.velocity, other.velocity = collide(
            self.pos, self.velocity, self.mass_kg, self.elasticity,
            other.pos, other.velocity, other.mass_kg, other.elasticity)
        self.pos, other.pos = collide_pos(
            self.pos, self.mass_kg, self.radius_m,
            other.pos, other.mass_kg, other.radius_m)
        return True

# TODO: lower height too, for upper hub
class Obstacle(Thing):
    """ has infinite mass """
    def __init__(self, unique_id: int, model: 'Model', pos, # type: ignore
        radius_m: float, z_height_m: float
    ) -> None:
        super().__init__(unique_id, model, pos, 1.0)
        self.pos = np.array(pos)
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
        pos,
        alliance: Alliance,
    ) -> None:
        super().__init__(unique_id, model, pos, 0.5) # elasticity 0.5
        # i measured elasticity of 0.5 for rolling collisions, using video
        self.alliance: Alliance = alliance
        self.radius_m = 0.12
        self.mass_kg = 0.27

    def update_velocity_for_rolling_friction(self) -> None:
        # balls in the air aren't affected by rolling friction
        if self.z_m > 0.01:
            return
        accel = GRAVITY_M_S_S * ROLLING_FRICTION_COEFFICIENT
        dv = accel * self.model.seconds_per_step # delta v during this step
        v_scalar = np.linalg.norm(self.velocity)
        if dv > v_scalar:
            self.velocity = np.zeros(2)
        else:
            v_ratio = dv / v_scalar
            self.velocity = np.multiply(self.velocity, 1-v_ratio)

    # TODO: also air resistance
    def update_v_z_for_gravity(self) -> None:
        self.vz_m_s -= GRAVITY_M_S_S * self.model.seconds_per_step

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
        self.check_wall_collision(self.model.space.width, self.model.space.height)
        self.update_pos_for_velocity(self.model.space.width, self.model.space.height)

class Robot(Thing):
    def __init__(self, unique_id: int, model: 'Model', # type: ignore
        pos,
        alliance: Alliance,
    ):
        super().__init__(unique_id, model, pos, 0.1)
        # seems like robot collisions are *really* inelastic
        self.radius_m: float = 0.50
        self.mass_kg: float = 56 # max allowed
        self.alliance: Alliance = alliance
        self.slot1: Optional[Cargo] = None # TODO: just make this a list
        self.slot2: Optional[Cargo] = None

    def step(self) -> None:
        # pick up nearby balls TODO: make this a process that takes time
        for item in self.model.space.get_neighbors(self.pos, 0.75, False):
            if isinstance(item, Cargo):
                # can only pick up balls that are close to the floor
                if item.z_m > 0.4:
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
            self.slot1.vz_m_s = 7 # TODO: ballistics
            self.model.space.place_agent(self.slot1, newpos)
            self.model.schedule.add(self.slot1)
            self.slot1 = None
        elif self.slot2 is not None:
            self.slot2.velocity = velocity
            self.slot2.vz_m_s = 7 # TODO: ballistics
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
            self.velocity += np.random.normal(loc=0.00, scale=0.05, size=2)
        self.check_wall_collision(self.model.space.width, self.model.space.height)
        self.update_pos_for_velocity(self.model.space.width, self.model.space.height)