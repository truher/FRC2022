"""
models collisions in the hub bucket
"""
from typing import Tuple
import numpy as np

"""
A bucket is a conical frustum facing up with base centered at (0, 0, 0).
"""
class Bucket():
    def __init__(self):
        self.vertex: float = -2
        self.theta_rad: float = np.pi/4
        self.height: float = 2

    @staticmethod
    def make_bucket(
        r_base: float, r_top: float, height: float) -> 'Bucket':
        dr = r_top - r_base
        if r_base <= 0 or r_top <= 0 or height <= 0:
            raise ValueError("positive arguments man")
        if dr <= 0:
            raise ValueError("top must be bigger than bottom")
        b = Bucket()
        b.theta_rad = np.arctan2(dr, height)
        b.height = height
        b.vertex = - r_base / np.tan(b.theta_rad)
        return b


    def is_inside(self, p: Tuple[float, float, float]) -> bool:
        return (
            self.is_inside_cone(p) and self.is_below_top(p) and self.is_above_base(p)
        )
    def is_inside_cone(self, p: Tuple[float, float, float]) -> bool:
        a = self.angle_rad(p)
        return a <= self.theta_rad

    def is_below_top(self, p: Tuple[float, float, float]) -> bool:
        return p[2] <= self.height

    def is_above_base(self, p: Tuple[float, float, float]) -> bool:
        return p[2] >= 0

    def angle_rad(self, p: Tuple[float, float, float]) -> float:
        d = np.subtract(p, (0, 0, self.vertex))
        dxy = np.hypot(d[0], d[1])
        return np.arctan2(dxy, d[2])

    def closest_point(self,
        p: Tuple[float, float, float]) -> Tuple[float, float, float]:
        epsilon = 0.001
        x = p[0]
        y = p[1]
        z = p[2]
        r = np.sqrt(x * x + y * y)
        if r < epsilon:
            raise ValueError("no unique value at the center")
        extra_z = r * np.tan(self.theta_rad)
        hypot = z - self.vertex + extra_z
        s = hypot * np.sin(self.theta_rad) * np.cos(self.theta_rad)
        sx = s * x / r
        sy = s * y / r
        gg = s / np.tan(self.theta_rad)
        sz = gg + self.vertex
        return (sx, sy, sz)

