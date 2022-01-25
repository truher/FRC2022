""" models collisions in the hub bucket """
from typing import Tuple
import numpy as np

class Bucket():
    """ A bucket is a conical frustum facing up with base centered at (0, 0, 0).  """
    def __init__(self, vertex, theta_rad, height) -> None:
        self._vertex: float = vertex
        self._theta_rad: float = theta_rad
        self._height: float = height
        self._n_z = np.sin(self._theta_rad) # unit normal z
        self._n_xy = - np.cos(self._theta_rad) # unit normal in xy plane

    @property
    def vertex(self) -> float:
        return self._vertex
    @property
    def theta_rad(self) -> float:
        return self._theta_rad
    @property
    def height(self) -> float:
        return self._height

    @staticmethod
    def make_bucket(
        r_base: float, r_top: float, height: float) -> 'Bucket':
        dr = r_top - r_base
        if r_base <= 0 or r_top <= 0 or height <= 0:
            raise ValueError("positive arguments man")
        if dr <= 0:
            raise ValueError("top must be bigger than bottom")
        return Bucket(
            - r_base * height / dr,
            np.arctan2(dr, height),
            height)

    def unit_normal(self, p: Tuple[float, float, float]) -> Tuple[float, float, float]:
        xy = np.sqrt(p[0] * p[0] + p[1] * p[1])
        A = self._n_xy / xy
        return (A*p[0], A*p[1], self._n_z)

    def distance(self, p: Tuple[float, float, float]) -> float:
        p_from_vertex = (p[0], p[1], p[2] - self.vertex)
        return np.dot(p_from_vertex, self.unit_normal(p))

    def is_inside(self, p: Tuple[float, float, float]) -> bool:
        return (
            self.is_inside_cone(p) and self.is_below_top(p) and self.is_above_base(p)
        )
    def is_inside_cone(self, p: Tuple[float, float, float]) -> bool:
        a = self.angle_rad(p)
        return a <= self.theta_rad

    def is_below_top(self, p: Tuple[float, float, float]) -> bool:
        return p[2] <= self.height

    @staticmethod
    def is_above_base(p: Tuple[float, float, float]) -> bool:
        return p[2] >= 0

    def angle_rad(self, p: Tuple[float, float, float]) -> float:
        d = np.subtract(p, (0, 0, self.vertex))
        dxy = np.hypot(d[0], d[1])
        return np.arctan2(dxy, d[2]) # type:ignore

    # use projection
    def closest_point2(self,
        p: Tuple[float, float, float]
    ) -> Tuple[float, float, float]:
        p_from_vertex: Tuple[float, float, float] = (p[0], p[1], p[2] - self.vertex)
        n: Tuple[float, float, float] = self.unit_normal(p)
        d: float = (p_from_vertex[0] * n[0]
                  + p_from_vertex[1] * n[1]
                  + p_from_vertex[2] * n[2])
        d_vec: Tuple[float, float, float] = (d*n[0], d*n[1], d*n[2])
        return (p[0] - d_vec[0],
                p[1] - d_vec[1],
                p[2] - d_vec[2])

    def closest_point(self,
        p: Tuple[float, float, float]
    ) -> Tuple[float, float, float]:
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
