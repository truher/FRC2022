import unittest
import numpy as np
from frc.collision import (
    collide, 
    collide_cylindrical,
    collide_pos_cylindrical,
    collide_pos) # pylint: disable=import-error

class TestCollision(unittest.TestCase):
    def test_collide_1d(self) -> None: # pylint: disable=no-self-use
        p1 = (0,0,0)
        v1 = (1,0,0)
        m1 = 1
        e1 = 1
        r1 = 1
        p2 = (1,0,0)
        v2 = (-1,0,0)
        m2 = 1
        e2 = 1
        r2 = 1
        newv1, newv2 = collide(p1, v1, m1, e1, p2, v2, m2, e2)
        np.testing.assert_almost_equal((-1,0,0), newv1)
        np.testing.assert_almost_equal((1,0,0), newv2)
        newp1, newp2 = collide_pos(p1, m1, r1, p2, m2, r2)
        np.testing.assert_almost_equal((-0.5,0,0), newp1)
        np.testing.assert_almost_equal((1.5,0,0), newp2)

    def test_collide_2d(self) -> None: # pylint: disable=no-self-use
        p1 = (0,0,0)
        v1 = (1,0,0)
        m1 = 1
        e1 = 1
        r1 = 1
        p2 = (1,1,0)
        v2 = (-1,0,0)
        m2 = 1
        e2 = 1
        r2 = 1
        newv1, newv2 = collide(p1, v1, m1, e1, p2, v2, m2, e2)
        np.testing.assert_almost_equal((0,-1,0), newv1)
        np.testing.assert_almost_equal((0,1,0), newv2)
        newp1, newp2 = collide_pos(p1, m1, r1, p2, m2, r2)
        np.testing.assert_almost_equal((-np.sqrt(0.5)+0.5,-np.sqrt(0.5)+0.5,0), newp1)
        np.testing.assert_almost_equal((np.sqrt(0.5)+0.5,np.sqrt(0.5)+0.5,0), newp2)

    def test_collide_spherical(self) -> None: # pylint: disable=no-self-use
        p1 = (0,0,0)
        v1 = (1,0,0)
        m1 = 1
        e1 = 1
        r1 = 1
        p2 = (1,0,1)
        v2 = (-1,0,0)
        m2 = 1
        e2 = 1
        r2 = 1

        newv1, newv2 = collide(p1, v1, m1, e1, p2, v2, m2, e2)
        np.testing.assert_almost_equal((0,0,-1), newv1)
        np.testing.assert_almost_equal((0,0,1), newv2)
        newp1, newp2 = collide_pos(p1, m1, r1, p2, m2, r2)
        np.testing.assert_almost_equal((-np.sqrt(0.5)+0.5,0,-np.sqrt(0.5)+0.5), newp1)
        np.testing.assert_almost_equal((np.sqrt(0.5)+0.5,0,np.sqrt(0.5)+0.5), newp2)

    # ignores z, should be like 1d
    def test_collide_cylindrical_x(self) -> None: # pylint: disable=no-self-use
        p1 = (0,0,0)
        v1 = (1,0,0)
        m1 = 1
        e1 = 1
        r1 = 1
        p2 = (1,0,1)
        v2 = (-1,0,0)
        m2 = 1
        e2 = 1
        r2 = 1
        newv1, newv2 = collide_cylindrical(p1, v1, m1, e1, p2, v2, m2, e2)
        np.testing.assert_almost_equal((-1,0,0), newv1)
        np.testing.assert_almost_equal((1,0,0), newv2)
        newp1, newp2 = collide_pos_cylindrical(p1, m1, r1, p2, m2, r2)
        np.testing.assert_almost_equal((-0.5,0,0), newp1)
        np.testing.assert_almost_equal((1.5,0,1), newp2)

    def test_collide_cylindrical_xy(self) -> None: # pylint: disable=no-self-use
        p1 = (0,0,0)
        v1 = (1,0,0)
        m1 = 1
        e1 = 1
        r1 = 1
        p2 = (1,1,1)
        v2 = (-1,0,0)
        m2 = 1
        e2 = 1
        r2 = 1
        newv1, newv2 = collide_cylindrical(p1, v1, m1, e1, p2, v2, m2, e2)
        np.testing.assert_almost_equal((0,-1,0), newv1)
        np.testing.assert_almost_equal((0,1,0), newv2)
        newp1, newp2 = collide_pos_cylindrical(p1, m1, r1, p2, m2, r2)
        np.testing.assert_almost_equal((-np.sqrt(0.5)+0.5,-np.sqrt(0.5)+0.5,0), newp1)
        np.testing.assert_almost_equal((np.sqrt(0.5)+0.5,np.sqrt(0.5)+0.5,1), newp2)
