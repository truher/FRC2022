from collections import deque
from typing import Any, Deque, Tuple

class Delay():
    def __init__(self, latency: float, throughput:float) -> None:
        """
            latency: items remain this long
            throughput: items released per time; TODO: parallel workers?
        """
        self.latency: float = latency
        self.min_get_period: float = 1/throughput
        self.latest_put_time: float = 0
        self.latest_get_time: float = 0
        self.deque: Deque[Tuple[Any, float]] = deque()

    @property
    def length(self) -> int:
        return len(self.deque)

    def put(self, item: Any, item_time: float) -> None:
        if item_time < self.latest_put_time: # inserts must be in time order
            raise ValueError(f"item_time {item_time} < latest put_time {self.latest_put_time}")
        self.latest_put_time = item_time
        self.deque.append((item, item_time))

    def get(self, as_of: float) -> Any:
        if len(self.deque) == 0:
            return None
        dt = as_of - self.latest_get_time
        if dt < 0:
            raise ValueError(f"as_of {as_of} < latest get_time {self.latest_get_time}")
        if dt < self.min_get_period:
            return None
        item_time: float = self.deque[0][1]
        if as_of > item_time + self.latency:
            self.latest_get_time = as_of
            return self.deque.popleft()[0]
        return None
