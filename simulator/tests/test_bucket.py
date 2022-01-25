import unittest
from typing import Tuple
import numpy as np
from frc.bucket import Bucket # pylint: disable=import-error

class TestBucket(unittest.TestCase):
    def test_bucket_internals(self) -> None:
        x = Bucket(-2, np.pi/4, 2)
        p: Tuple[float, float, float] = (0, 0, 0) # base center
        self.assertAlmostEqual(0, x.angle_rad(p))
        self.assertTrue(x.is_inside_cone(p))
        self.assertTrue(x.is_below_top(p))
        self.assertTrue(x.is_above_base(p))
        self.assertTrue(x.is_inside(p))
        p = (0, 0, 5) # zenith
        self.assertAlmostEqual(0, x.angle_rad(p))
        self.assertTrue(x.is_inside_cone(p))
        self.assertFalse(x.is_below_top(p))
        self.assertTrue(x.is_above_base(p))
        self.assertFalse(x.is_inside(p))
        p = (0, 0, -5) # nadir
        self.assertAlmostEqual(np.pi, x.angle_rad(p))
        self.assertFalse(x.is_inside_cone(p))
        self.assertTrue(x.is_below_top(p))
        self.assertFalse(x.is_above_base(p))
        self.assertFalse(x.is_inside(p))
        p = (1, 0, -2) # west
        self.assertAlmostEqual(np.pi/2, x.angle_rad(p))
        self.assertFalse(x.is_inside_cone(p))
        self.assertTrue(x.is_below_top(p))
        self.assertFalse(x.is_above_base(p))
        self.assertFalse(x.is_inside(p))
        p = (3, 0, 1) # on boundary
        self.assertAlmostEqual(np.pi/4, x.angle_rad(p))
        self.assertTrue(x.is_inside_cone(p))
        self.assertTrue(x.is_below_top(p))
        self.assertTrue(x.is_above_base(p))
        self.assertTrue(x.is_inside(p))
        p = (3, 0, 1.5) # above
        self.assertTrue(x.is_inside_cone(p))
        self.assertTrue(x.is_below_top(p))
        self.assertTrue(x.is_above_base(p))
        self.assertTrue(x.is_inside(p))
        p = (3, 0, 0.5) # below
        self.assertFalse(x.is_inside_cone(p))
        self.assertTrue(x.is_below_top(p))
        self.assertTrue(x.is_above_base(p))
        self.assertFalse(x.is_inside(p))

    def test_bucket_creation(self) -> None:
        x = Bucket.make_bucket(1, 2, 2)
        self.assertAlmostEqual(-2, x.vertex)
        self.assertAlmostEqual(np.arctan2(1,2), x.theta_rad)
        self.assertAlmostEqual(2, x.height)

    def test_closest_point(self) -> None:
        x = Bucket.make_bucket(1, 2, 1)
        np.testing.assert_almost_equal((1.5, 0, 0.5), x.closest_point((1, 0, 1)))
        # outside?
        np.testing.assert_almost_equal((1.5, 0, 0.5), x.closest_point((2, 0, 0)))
        np.testing.assert_almost_equal((1, 0, 0), x.closest_point((0.5, 0, 0.5)))
        np.testing.assert_almost_equal((0, 1, 0), x.closest_point((0, 0.5, 0.5)))
        with self.assertRaises(ValueError):
            x.closest_point((0, 0, 1))
        x = Bucket.make_bucket(1, 2, 2)
        np.testing.assert_almost_equal((2,0,2), x.closest_point((1, 0, 2.5)))

    def test_unit_normal(self) -> None:
        x = Bucket.make_bucket(1, 2, 1)
        self.assertAlmostEqual(45, np.degrees(x.theta_rad))
        np.testing.assert_almost_equal((-0.5, -0.5, np.sqrt(0.5)), x.unit_normal((1, 1, 1)))
        np.testing.assert_almost_equal((-np.sqrt(0.5), 0, np.sqrt(0.5)), x.unit_normal((1, 0, 1)))
        self.assertAlmostEqual(np.sqrt(2)/2, x.distance((1, 0, 1)))
        self.assertAlmostEqual(-np.sqrt(2)/2, x.distance((2, 0, 0))) # below = negative
        self.assertAlmostEqual(np.sqrt(2), x.distance((1, 0, 2)))
        np.testing.assert_almost_equal((1.5, 0.0, 0.5), x.closest_point2((1, 0, 1))) # above
        np.testing.assert_almost_equal((1.5, 0.0, 0.5), x.closest_point2((2, 0, 0))) # below

if __name__ == '__main__':
    unittest.main()
