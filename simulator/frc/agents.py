import numpy as np
from mesa import Agent
from .alliance import Alliance
from .collision import collide, collide_pos, overlap

# TODO: do this differently
X_MAX_M = 16.46
Y_MAX_M = 8.23
CENTER = np.array((X_MAX_M/2, Y_MAX_M/2))


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

class Thing(Agent):
    def __init__(self, unique_id: int, model: 'Model',
        pos, elasticity
    ) -> None:
        super().__init__(unique_id, model)
        self.pos = np.array(pos) # TODO: remove this, place_agent does it.
        self.elasticity = elasticity
        self._velocity = np.zeros(2)
        self.z_m = 0
        self.vz_m_s = 0

    @property
    def speed(self):
        return np.linalg.norm(self._velocity)

    def update_pos_for_velocity(self, size_x, size_y):
        if self.pos is None:
            # we're in some delay somewhere
            return
        self.pos += self._velocity * self.model.seconds_per_step
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
            self.z_m = 0

    def is_colliding(self, other):
        return overlap(other.pos, self.pos, other.radius_m, self.radius_m)

    def check_wall_collision(self, size_x, size_y):
        out = False
        if self.pos[0] <= self.radius_m:
            # blue wall 197cm high
            if self.z_m > END_WALL_HEIGHT_M:
                out = True
            self.pos[0] = self.radius_m
            self._velocity[0] = -self._velocity[0] * self.elasticity
        elif self.pos[0] >= (x2_bound := (size_x - self.radius_m)):
            # red wall 197cm high
            if self.z_m > END_WALL_HEIGHT_M:
                out = True
            self.pos[0] = x2_bound
            self._velocity[0] = -self._velocity[0] * self.elasticity
        if self.pos[1] <= self.radius_m:
            # side wall 51cm high
            if self.z_m > SIDE_WALL_HEIGHT_M:
                out = True
            self.pos[1] = self.radius_m
            self._velocity[1] = -self._velocity[1] * self.elasticity
        elif self.pos[1] >= (y2_bound := (size_y - self.radius_m)):
            # side wall 51cm high
            if self.z_m > SIDE_WALL_HEIGHT_M:
                out = True
            self.pos[1] = y2_bound
            self._velocity[1] = -self._velocity[1] * self.elasticity
        if out:
            self.model.space.remove_agent(self)
            self.model.schedule.remove(self)
            self.model.out_of_bounds.put(self, self.model.model_time)
            return
        # bounce off the floor
        if self.z_m < 0:
            self.z_m = 0
            self.vz_m_s = -self.vz_m_s * VERTICAL_ELASTICITY

    def check_ball_collision(self, other) -> bool: # if actually colliding
        if not self.is_colliding(other):
            return False
        # balls above robots don't collide (with each other either)
        # TODO: handle the hub case separately
        if self.z_m > 1.32 or other.z_m > 1.32:
            return False
        d = np.linalg.norm(self.pos-other.pos)
        self._velocity, other._velocity = collide(
            self.pos, self._velocity, self.mass_kg, self.elasticity,
            other.pos, other._velocity, other.mass_kg, other.elasticity)
        self.pos, other.pos = collide_pos(
            self.pos, self.mass_kg, self.radius_m,
            other.pos, other.mass_kg, other.radius_m)
        return True

class Obstacle(Thing):
    """ has infinite mass """
    def __init__(self, unique_id: int, model: 'Model', pos) -> None:
        super().__init__(unique_id, model, pos, 1.0)
        self.pos = np.array(pos)
        self.radius_m = 0.045 # terminal posts are  ~4.5cm wide
        self.mass_kg = np.inf

    def step(self): # override: never moves, so just check collisions
        for other in self.model.space.get_neighbors(self.pos, 4, False): # 2m neighborhood
            if self.unique_id >= other.unique_id:
                continue
            self.check_ball_collision(other)

class Cargo(Thing):
    def __init__(self, unique_id: int, model: 'Model',
        pos,
        alliance: Alliance,
    ) -> None:
        super().__init__(unique_id, model, pos, 0.5) # elasticity 0.5
        # i measured elasticity of 0.5 for rolling collisions, using video
        self.alliance: Alliance = alliance
        self.radius_m = 0.12
        self.mass_kg = 0.27

    def update_velocity_for_rolling_friction(self):
        # balls in the air aren't affected by rolling friction
        if self.z_m > 0.01:
            return
        accel = GRAVITY_M_S_S * ROLLING_FRICTION_COEFFICIENT
        dv = accel * self.model.seconds_per_step # delta v during this step
        v_scalar = np.linalg.norm(self._velocity)
        if dv > v_scalar:
            self._velocity = np.zeros(2)
        else:
            v_ratio = dv / v_scalar
            self._velocity = np.multiply(self._velocity, 1-v_ratio)

    # TODO: also air resistance
    def update_v_z_for_gravity(self):
        self.vz_m_s -= GRAVITY_M_S_S * self.model.seconds_per_step

    def step(self):
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
    def __init__(self, unique_id: int, model: 'Model',
        pos,
        alliance: Alliance,
    ):
        super().__init__(unique_id, model, pos, 0.1)
        # seems like robot collisions are *really* inelastic
        self.radius_m = 0.50
        self.mass_kg = 56 # max allowed
        self.alliance: Alliance = alliance
        self.slot1 = None # TODO: just make this a list
        self.slot2 = None

    def step(self):
        # pick up nearby balls TODO: make this a process that takes time
        for item in self.model.space.get_neighbors(self.pos, 0.75, False):
            if isinstance(item, Cargo):
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
            print("shoot 1")
            self.slot1._velocity = velocity
            self.slot1.vz_m_s = 7 # TODO: ballistics
            self.model.space.place_agent(self.slot1, newpos)
            self.model.schedule.add(self.slot1)
            self.slot1 = None
        elif self.slot2 is not None:
            print("shoot 2")
            self.slot2._velocity = velocity
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
            self._velocity += np.random.normal(loc=0.00, scale=0.05, size=2)
        self.check_wall_collision(self.model.space.width, self.model.space.height)
        self.update_pos_for_velocity(self.model.space.width, self.model.space.height)
