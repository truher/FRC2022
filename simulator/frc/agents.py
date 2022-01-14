import numpy as np
from mesa import Agent
from .alliance import Alliance
from .collision import collide, overlap

STEP_SIZE_S = 0.1 # TOOD fix this
ELASTICITY = 0.25 # ???

class Thing(Agent):
    def __init__(self, unique_id: int, model: 'Model',
        pos
    ) -> None:
        super().__init__(unique_id, model)
        self.pos = np.array(pos)
        self.nextpos = self.pos
        self.in_collision = [] # avoid duplication in pairs

    def advance(self):
        self.model.space.move_agent(self, self.nextpos)

    def time_step(self):
        self.nextpos = self.pos + self._velocity * STEP_SIZE_S

    def is_colliding(self, other):
        return overlap(other.pos, self.pos, other.radius_m, self.radius_m)

    # TODO: the wall is not a rectangle so this will have to change somehow
    def check_wall_collision(self, size_x, size_y):
        if self.nextpos[0] <= self.radius_m:
            self.nextpos[0] = self.radius_m
            self._velocity[0] = -self._velocity[0]
        elif self.nextpos[0] >= (x2_bound := (size_x - self.radius_m)):
            self.nextpos[0] = x2_bound
            self._velocity[0] = -self._velocity[0]
        if self.nextpos[1] <= self.radius_m:
            self.nextpos[1] = self.radius_m
            self._velocity[1] = -self._velocity[1]
        elif self.nextpos[1] >= (y2_bound := (size_y - self.radius_m)):
            self.nextpos[1] = y2_bound
            self._velocity[1] = -self._velocity[1]
            #print(f"wall {self.nextpos[1]}")

    def check_ball_collision(self, other):
        if self.is_colliding(other):
            if other not in self.in_collision:
                self._velocity, other._velocity = collide(
                    self.pos, self._velocity, self.mass_kg, 0.25,
                    other.pos, other._velocity, other.mass_kg, 0.25)
                self.in_collision.append(other)
                other.in_collision.append(self)
        elif other in self.in_collision:
            self.in_collision.remove(other)
            other.in_collision.remove(self)

class Cargo(Thing):
    def __init__(self, unique_id: int, model: 'Model',
        pos,
        alliance: Alliance,
    ) -> None:
        super().__init__(unique_id, model, pos)
        self.alliance: Alliance = alliance
        self.radius_m = 0.12
        self.mass_kg = 0.27
        self._velocity = np.random.random(2) * 0.02 - 0.01

    def step(self):
        self.time_step()
        self.check_wall_collision(self.model.space.width, self.model.space.height)

        neighbors = self.model.space.get_neighbors(self.pos, 2, False) # 2m neighborhood
        for neighbor in neighbors:
            self.check_ball_collision(neighbor)

class Robot(Thing):
    def __init__(self, unique_id: int, model: 'Model',
        pos,
        alliance: Alliance,
    ):
        super().__init__(unique_id, model, pos)
        self.radius_m = 0.50
        self.mass_kg = 56 # max allowed
        self.alliance: Alliance = alliance
        self._velocity = np.random.random(2) * 0.02 - 0.01

    def step(self):
        # wiggle
        self._velocity += np.random.normal(loc=0.00, scale=0.05, size=2)
        self.time_step()
        self.check_wall_collision(self.model.space.width, self.model.space.height)

        neighbors = self.model.space.get_neighbors(self.pos, 2, False) # 2m neighborhood
        for neighbor in neighbors:
            self.check_ball_collision(neighbor)
