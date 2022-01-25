# collision calculations
from typing import Tuple
import numpy as np
from numpy.typing import NDArray

R3 = Tuple[float, float, float]
ROTATION: NDArray[np.float64] = np.array([[0, -1, 0], [1, 0, 0], [0, 0, 1]])


def overlap(p1: R3, p2: R3, r1: float, r2: float) -> bool:
    distance_vector = np.subtract(p1, p2)
    minimum_distance = r1 + r2
    distance_scalar = np.linalg.norm(distance_vector)
    return bool(distance_scalar < minimum_distance)

def collide(p1: R3, v1: R3, m1: float, e1: float,
            p2: R3, v2: R3, m2: float, e2: float) -> Tuple[R3, R3]:

    # FIXME: max so that balls are bouncy but robots are not, this is clearly wrong
    e: float = max(e1, e2)
    d: R3 = np.subtract(p2, p1)

    # TODO remove all linalg, it's slow
    unit_normal_vector: R3 = np.divide(d, np.linalg.norm(d))

    unit_tangent_vector: R3 = np.dot(ROTATION, unit_normal_vector)

    normal_scalar_before_1: float = np.dot(v1, unit_normal_vector)
    tangent_scalar_1: float = np.dot(v1, unit_tangent_vector)

    normal_scalar_before_2: float = np.dot(v2, unit_normal_vector)
    tangent_scalar_2: float = np.dot(v2, unit_tangent_vector)

    normal_scalar_after_1: float
    normal_scalar_after_2: float
    if np.isinf(m1):
        normal_scalar_after_1 = normal_scalar_before_1
        normal_scalar_after_2 = (- normal_scalar_before_2 * e
            + (e + 1) * normal_scalar_before_1)
    elif np.isinf(m2):
        normal_scalar_after_1 = (- normal_scalar_before_1 * e
            + (e + 1) * normal_scalar_before_2)
        normal_scalar_after_2 = normal_scalar_before_2
    else:
        normal_scalar_after_1 = ( (normal_scalar_before_1 * (m1 - e * m2))
            + ((e + 1) * m2 * normal_scalar_before_2)) / (m1 + m2)
        normal_scalar_after_2 = ( (normal_scalar_before_2 * (m2 - e * m1))
            + ((e + 1) * m1 * normal_scalar_before_1)) / (m1 + m2)

    normal_vector_after_1: R3 = np.multiply(normal_scalar_after_1, unit_normal_vector)
    tangent_vector_after_1: R3 = np.multiply(tangent_scalar_1, unit_tangent_vector)

    normal_vector_after_2: R3 = np.multiply(normal_scalar_after_2, unit_normal_vector)
    tangent_vector_after_2: R3 = np.multiply(tangent_scalar_2, unit_tangent_vector)

    newv1: R3 = np.add(normal_vector_after_1, tangent_vector_after_1)
    newv2: R3 = np.add(normal_vector_after_2, tangent_vector_after_2)

    return newv1, newv2

# the problem with the velocity approach above is that a collision is detected *after*
# the objects intersect and with an inelastic collisions, the outcome can easily leave
# the objects still intersected, so the collision is run again, but this time with velocities
# that don't make sense.  so the objects can collide over and over.
# the simplest fix i could think of is what the wall-collision thing does, which is
# to just force the objects apart.
def collide_pos(p1: R3, m1: float, r1: float,
                p2: R3, m2: float, r2: float) -> Tuple[R3, R3]:
    d: R3 = np.subtract(p2, p1)
    d_scalar = np.linalg.norm(d)
    unit_normal_vector: R3 = np.divide(d, d_scalar)
    min_distance: float = r1 + r2
    normal_vector_min_distance = np.multiply(min_distance + 0.001, unit_normal_vector)
    squish_vector = np.subtract(normal_vector_min_distance, d)
    if np.isinf(m1):
        p1_after = p1
        p2_after = np.add(p2, squish_vector)
    elif np.isinf(m2):
        p1_after = np.subtract(p1, squish_vector)
        p2_after = p2
    else:
        # scale the fix-up by mass
        relative_mass_1 = m1 / (m1 + m2)
        relative_mass_2 = m2 / (m1 + m2)
        p1_after = np.subtract(p1, np.multiply(relative_mass_2, squish_vector))
        p2_after = np.add(p2, np.multiply(relative_mass_1, squish_vector))
    return p1_after, p2_after
