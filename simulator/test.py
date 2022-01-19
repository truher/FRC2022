import numpy as np
import unittest
from frc.bucket import Bucket
from frc.delay import Delay

class TestDelay(unittest.TestCase):
    def test_delay(self) -> None:
        x = Delay(5, 0.2)
        self.assertIsNone(x.get(0)) # nothing there yet
        x.put("foo", 0)
        self.assertIsNone(x.get(0)) # not time yet
        self.assertIsNone(x.get(5)) # not time yet
        self.assertEqual("foo", x.get(6))
        self.assertIsNone(x.get(7)) # empty again
        x.put("foo", 10)
        with self.assertRaises(ValueError):
            x.put("foo", 0) # no writing into the past
        x.put("foo", 10) # writing in the *same* time is fine
        self.assertEqual("foo", x.get(16))
        self.assertIsNone(x.get(16)) # wait after successful get
        self.assertEqual("foo", x.get(21)) # duplicate items is fine
        self.assertIsNone(x.get(16))

class TestBucket(unittest.TestCase):
    def test_bucket_internals(self) -> None:
        x = Bucket()
        p = (0, 0, 0) # base center
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

if __name__ == '__main__':
    unittest.main()
