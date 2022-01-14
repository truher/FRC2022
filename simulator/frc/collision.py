# collision calculations
import numpy as np
from numpy.typing import ArrayLike
from typing import Tuple

def overlap(p1: ArrayLike, p2: ArrayLike, r1: float, r2: float) -> bool:
    distance_vector = np.subtract(p1, p2)
    minimum_distance = r1 + r2
    distance_scalar = np.linalg.norm(distance_vector)
    return bool(distance_scalar <= minimum_distance)

def collide(p1: ArrayLike, v1: ArrayLike, m1: float, e1: float,
            p2: ArrayLike, v2: ArrayLike, m2: float, e2: float) -> Tuple[ArrayLike, ArrayLike]:

    e: float = min(e1, e2)
    d: ArrayLike = np.subtract(p2, p1)

    unit_normal_vector: ArrayLike = np.divide(d, np.linalg.norm(d))
    rot: ArrayLike = np.array([[0, -1], [1, 0]])
    unit_tangent_vector: ArrayLike = np.dot(rot, unit_normal_vector)

    normal_scalar_before_1: float = np.dot(v1, unit_normal_vector)
    tangent_scalar_1: float = np.dot(v1, unit_tangent_vector)

    normal_scalar_before_2: float = np.dot(v2, unit_normal_vector)
    tangent_scalar_2: float = np.dot(v2, unit_tangent_vector)

    normal_scalar_after_1: float = ( (normal_scalar_before_1 * (m1 - e * m2))
        + ((e + 1) * m2 * normal_scalar_before_2)) / (m1 + m2)

    normal_scalar_after_2: float = ( (normal_scalar_before_2 * (m2 - e * m1))
        + ((e + 1) * m1 * normal_scalar_before_1)) / (m1 + m2)

    normal_vector_after_1: ArrayLike = np.multiply(normal_scalar_after_1, unit_normal_vector)
    tangent_vector_after_1: ArrayLike = np.multiply(tangent_scalar_1, unit_tangent_vector)

    normal_vector_after_2: ArrayLike = np.multiply(normal_scalar_after_2, unit_normal_vector)
    tangent_vector_after_2: ArrayLike = np.multiply(tangent_scalar_2, unit_tangent_vector)

    newv1: ArrayLike = np.add(normal_vector_after_1, tangent_vector_after_1)
    newv2: ArrayLike = np.add(normal_vector_after_2, tangent_vector_after_2)

    return newv1, newv2
