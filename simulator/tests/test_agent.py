import unittest
from typing import Any
import numpy as np

from frc.agent import Thing # pylint: disable=import-error

class FakeSpace():
    def move_agent(self, x: Any, y: Any) -> None:
        pass
class FakeModel():
    def __init__(self) -> None:
        self.seconds_per_step = 1
        self.space = FakeSpace()

class TestAgent(unittest.TestCase):
    def test_pos(self) -> None:
        m = FakeModel()
        x = Thing(0, m, (0,0,0), 0)
        np.testing.assert_almost_equal((0,0,0), x.velocity)
        np.testing.assert_almost_equal((0,0,0), x.pos)
        self.assertEqual(0, x.speed)
        x.update_pos_for_velocity(10, 10)
        y = Thing(0, m, (1,0,0), 0)
        self.assertFalse(x.is_colliding(y))
        x.check_wall_collision(10, 10)
        x.check_ball_collision(y)
