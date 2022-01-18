from mesa import Agent
from mesa.visualization.ModularVisualization import VisualizationElement
from typing import Callable

class Simple3dCanvas(VisualizationElement):
    local_includes = [ "frc/simple_3d_continuous_canvas.js" ]

    def __init__(self,
        portrayal_method: Callable[[Agent], dict],
        canvas_width: int,
        canvas_height: int
        ):
        self._portrayal_method = portrayal_method
        self.canvas_height = canvas_height
        self.canvas_width = canvas_width
        self.js_code = (
            "import {Simple_3d_Continuous_Module} from './local/frc/simple_3d_continuous_canvas.js';\n"
            f"elements.push(new Simple_3d_Continuous_Module());"
        )

    def render(self, model):
        space_state = []
        for obj in model.schedule.agents:
            portrayal = self._portrayal_method(obj)
            portrayal["x"] = obj.pos[0]
            portrayal["y"] = obj.pos[1]
            space_state.append(portrayal)
        return space_state
