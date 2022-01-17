import unittest
from frc.delay import Delay

class TestDelay(unittest.TestCase):
    def test_delay(self) -> None:
        x = Delay(5)
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
        self.assertIsNone(x.get(2)) # asking about the past is fine
        self.assertEqual("foo", x.get(16)) # duplicate items is fine
        self.assertIsNone(x.get(16))

    def test_delay(self) -> None:
        x = Delay(5)
        x.put("foo0", 0)
        x.put("foo1", 1)
        x.put("foo2", 2)
        x.put("foo3", 3)
        self.assertEqual(4, x.length)
        y = x.select(6.5)
        self.assertEqual(2, len(y))

if __name__ == '__main__':
    unittest.main()
