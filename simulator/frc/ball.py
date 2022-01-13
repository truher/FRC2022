import math
import numpy as np

class Ball:
    def __init__(self, x, y, r, vx, vy, e):
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
        return np.linalg.norm(other.position - self.position) <= self.__radius + other.__radius

    def check_ball_collision(self, other):
        if self.is_colliding(other):
            if other not in self.__in_collision:
                e = min(self.__elasticity, other.__elasticity)
                d = other.position - self.position

                unit_normal_vector = d / np.linalg.norm(d)
                unit_tangent_vector = np.array((-unit_normal_vector[1], unit_normal_vector[0]))

                self_normal_scalar_before = np.dot(self.__velocity, unit_normal_vector)
                self_tangent_scalar = np.dot(self.__velocity, unit_tangent_vector)

                other_normal_scalar_before = np.dot(other.__velocity, unit_normal_vector)
                other_tangent_scalar = np.dot(other.__velocity, unit_tangent_vector)

                self_normal_scalar_after = (
                    (self_normal_scalar_before * (self.mass - e * other.mass))
                    + ((e + 1) * other.mass * other_normal_scalar_before)
                ) / (self.mass + other.mass)

                other_normal_scalar_after = (
                    (other_normal_scalar_before * (other.mass - e * self.mass))
                    + ((e + 1) * self.mass * self_normal_scalar_before)
                ) / (self.mass + other.mass)

                self_normal_vector_after = self_normal_scalar_after * unit_normal_vector
                self_tangent_vector_after = self_tangent_scalar * unit_tangent_vector

                other_normal_vector_after = other_normal_scalar_after * unit_normal_vector
                other_tangent_vector_after = other_tangent_scalar * unit_tangent_vector

                self.__velocity = self_normal_vector_after + self_tangent_vector_after
                other.__velocity = other_normal_vector_after + other_tangent_vector_after

                self.__in_collision.append(other)
                other.__in_collision.append(self)

        elif other in self.__in_collision:
            self.__in_collision.remove(other)
            other.__in_collision.remove(self)
