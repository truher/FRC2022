import unittest
import random
from typing import Callable
import numpy as np
import trajectory

def capture(energy) -> Callable[[int], bool]:
    def a(_: int) -> bool:
        return trajectory.is_captured(energy)
    return a

def compute_capture_probability(energy) -> float:
    return np.mean(list(map(int, map(capture(energy), range(1000)))))

class TestTrajectory(unittest.TestCase):
    def test_run(self) -> None:
        outcome, energy, _ = trajectory.run(1, 1, 1, True)
        self.assertEqual("miss", outcome)
        self.assertAlmostEqual(0.178, energy, 2)

    def test_capture(self) -> None:
        random.seed(0) # so the numbers below are always the same
        self.assertTrue(trajectory.is_captured(0)) # zero energy is always captured
        self.assertAlmostEqual(1, compute_capture_probability(0.0), 2)
        self.assertAlmostEqual(1, compute_capture_probability(1.0), 2)
        self.assertAlmostEqual(1, compute_capture_probability(2.0), 2)
        self.assertAlmostEqual(1, compute_capture_probability(3.0), 2)
        self.assertAlmostEqual(0.715, compute_capture_probability(4.0), 2)
        self.assertAlmostEqual(0.49, compute_capture_probability(5.0), 2)
        self.assertAlmostEqual(0.478, compute_capture_probability(6.0), 2)
        self.assertAlmostEqual(0.456, compute_capture_probability(7.0), 2)
        self.assertAlmostEqual(0.343, compute_capture_probability(8.0), 2)
        self.assertAlmostEqual(0.244, compute_capture_probability(9.0), 2)
        self.assertAlmostEqual(0.241, compute_capture_probability(10.0), 2)
        self.assertAlmostEqual(0.264, compute_capture_probability(11.0), 2)
        self.assertAlmostEqual(0.255, compute_capture_probability(12.0), 2)
        self.assertAlmostEqual(0.219, compute_capture_probability(13.0), 2)
        self.assertAlmostEqual(0.203, compute_capture_probability(14.0), 2)
        self.assertAlmostEqual(0.203, compute_capture_probability(15.0), 2)
        self.assertAlmostEqual(0.193, compute_capture_probability(16.0), 2)
        self.assertAlmostEqual(0.128, compute_capture_probability(17.0), 2)
        self.assertAlmostEqual(0.129, compute_capture_probability(18.0), 2)
        self.assertAlmostEqual(0.107, compute_capture_probability(19.0), 2)
        self.assertAlmostEqual(0.124, compute_capture_probability(20.0), 2)

if __name__ == "__main__":
    unittest.main()
