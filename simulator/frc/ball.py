import math
import numpy as np
from .collision import collide, overlap

class Ball:
    def __init__(self, x, y, r, vx, vy, e: float) -> None:
        self.position = np.array((x,y))
        self.__radius = r
        self.__velocity = np.array((vx, vy))
        self.__elasticity = e
        self.__in_collision = []

    @property
    def mass(self):
        return self.__radius**2

    def time_step(self, num_steps):
        self.position += self.__velocity / num_steps

    # TODO: make these inelastic
    def check_wall_collision(self, size_x, size_y):
        if self.position[0] <= self.__radius:
            self.position[0] = self.__radius
            self.__velocity[0] = -self.__velocity[0]
        elif self.position[0] >= (x2_bound := (size_x - self.__radius)):
            self.position[0] = x2_bound
            self.__velocity[0] = -self.__velocity[0]
        elif self.position[1] <= self.__radius:
            self.position[1] = self.__radius
            self.__velocity[1] = -self.__velocity[1]
        elif self.position[1] >= (y2_bound := (size_y - self.__radius)):
            self.position[1] = y2_bound
            self.__velocity[1] = -self.__velocity[1]

    def is_colliding(self, other):
        return overlap(other.position, self.position, other.__radius, self.__radius)

    def check_ball_collision(self, other):
        if self.is_colliding(other):
            if other not in self.__in_collision:
                self.__velocity, other.__velocity = collide(
                    self.position, self.__velocity, self.mass, self.__elasticity,
                    other.position, other.__velocity, other.mass, other.__elasticity)

                self.__in_collision.append(other)
                other.__in_collision.append(self)

        elif other in self.__in_collision:
            self.__in_collision.remove(other)
            other.__in_collision.remove(self)
