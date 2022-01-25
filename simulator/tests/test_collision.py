import unittest
import numpy as np
from frc.collision import collide # pylint: disable=import-error

class TestCollision(unittest.TestCase):
    def test_collide(self) -> None: # pylint: disable=no-self-use
        p1 = (0,0,0)
        v1 = (-1,0,0)
        m1 = 1
        e1 = 1
        p2 = (1,0,0)
        v2 = (1,0,0)
        m2 = 1
        e2 = 1
        newv1, newv2 = collide(p1, v1, m1, e1, p2, v2, m2, e2)
        np.testing.assert_almost_equal((1,0,0), newv1)
        np.testing.assert_almost_equal((-1,0,0), newv2)
