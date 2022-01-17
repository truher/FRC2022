from collections import deque
from typing import Any, Deque, Tuple

class Delay():
    def __init__(self, latency: float) -> None:
        self.latency: float = latency
        self.latest_time: float = 0
        self.deque: Deque[Tuple[Any, float]] = deque()

    def put(self, item: Any, item_time: float) -> None:
        if item_time < self.latest_time: # inserts must be in time order
            raise ValueError(f"item_time {item_time} < latest time {self.latest_time}")
        self.latest_time = item_time
        self.deque.append((item, item_time))

    def get(self, as_of: float) -> Any:
        if len(self.deque) == 0:
            return None
        item: Any
        item_time: float
        item, item_time = self.deque[0]
        if as_of > item_time + self.latency:
            return self.deque.popleft()[0]
        return None
