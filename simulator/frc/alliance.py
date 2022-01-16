from enum import Enum
class Alliance(Enum):
    NULL = ("white")
    RED = ("red")
    BLUE = ("blue")

    def __init__(self, color: str) -> None:
        self.color: str = color
