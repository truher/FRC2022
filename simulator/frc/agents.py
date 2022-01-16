import numpy as np
from mesa import Agent
from .alliance import Alliance
from .collision import collide, collide_pos, overlap

STEP_SIZE_S = 0.05 # TOOD fix this
ELASTICITY = 0.25 # ???
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

    @property
    def speed(self):
        return np.linalg.norm(self._velocity)

    def update_pos_for_velocity(self, size_x, size_y):
        self.pos += self._velocity * STEP_SIZE_S
        if self.pos[0] <= self.radius_m:
            self.pos[0] = self.radius_m
        elif self.pos[0] >= (x2_bound := (size_x - self.radius_m)):
            self.pos[0] = x2_bound
        if self.pos[1] <= self.radius_m:
            self.pos[1] = self.radius_m
        elif self.pos[1] >= (y2_bound := (size_y - self.radius_m)):
            self.pos[1] = y2_bound
        self.model.space.move_agent(self, self.pos)

    def is_colliding(self, other):
        return overlap(other.pos, self.pos, other.radius_m, self.radius_m)

    def check_wall_collision(self, size_x, size_y):
        if self.pos[0] <= self.radius_m:
            self.pos[0] = self.radius_m
            self._velocity[0] = -self._velocity[0] * self.elasticity
        elif self.pos[0] >= (x2_bound := (size_x - self.radius_m)):
            self.pos[0] = x2_bound
            self._velocity[0] = -self._velocity[0] * self.elasticity
        if self.pos[1] <= self.radius_m:
            self.pos[1] = self.radius_m
            self._velocity[1] = -self._velocity[1] * self.elasticity
        elif self.pos[1] >= (y2_bound := (size_y - self.radius_m)):
            self.pos[1] = y2_bound
            self._velocity[1] = -self._velocity[1] * self.elasticity

    def check_ball_collision(self, other) -> bool: # if actually colliding
        if not self.is_colliding(other):
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
        super().__init__(unique_id, model, pos, 0.5)
        # i measured elasticity of 0.5 for rolling collisions, using video
        self.alliance: Alliance = alliance
        self.radius_m = 0.12
        self.mass_kg = 0.27


    def update_velocity_for_rolling_friction(self):
        accel = GRAVITY_M_S_S * ROLLING_FRICTION_COEFFICIENT
        dv = accel * STEP_SIZE_S # delta v during this step
        v_scalar = np.linalg.norm(self._velocity)
        if dv > v_scalar:
            self._velocity = 0
        else:
            v_ratio = dv / v_scalar
            self._velocity = np.multiply(self._velocity, 1-v_ratio)

    def step(self):
        collided = False # don't try to apply any other forces in collisions
        for other in self.model.space.get_neighbors(self.pos, 2, False): # 2m neighborhood
            if self.unique_id >= other.unique_id:
                continue
            if self.check_ball_collision(other):
                collided = True
        if not collided:
            self.update_velocity_for_rolling_friction()
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

    def step(self):
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
