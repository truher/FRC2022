from typing import Any, Callable, Dict, List
from mesa import Agent, Model # type: ignore
from mesa.visualization.ModularVisualization import VisualizationElement # type: ignore

class SimpleCanvas(VisualizationElement): # type:ignore
    local_includes = ["frc/simple_continuous_canvas.js"]

    def __init__(self, # pylint: disable=super-init-not-called
        portrayal_method: Callable[[Agent], Dict[Any, Any]],
        canvas_width: int,
        canvas_height: int
        ):
        self._portrayal_method = portrayal_method
        self.canvas_height = canvas_height
        self.canvas_width = canvas_width
        self.js_code = (
            "import {Simple_Continuous_Module} from './local/frc/simple_continuous_canvas.js';\n"
            f"elements.push(new Simple_Continuous_Module({self.canvas_width}, {self.canvas_height}));"
        )

    def render(self, model: Model) -> List[Any]:
        space_state = []
        for obj in model.schedule.agents:
            portrayal = self._portrayal_method(obj)
            portrayal["x"] = obj.pos[0]
            portrayal["y"] = obj.pos[1]
            space_state.append(portrayal)
        return space_state
