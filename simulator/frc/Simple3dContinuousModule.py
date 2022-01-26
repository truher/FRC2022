from typing import Any, Callable, Dict, List
from mesa import Agent, Model # type: ignore
from mesa.visualization.ModularVisualization import VisualizationElement # type: ignore

class Simple3dCanvas(VisualizationElement): # type:ignore
    local_includes = [ "frc/simple_3d_continuous_canvas.js" ]

    def __init__(self, # pylint: disable=super-init-not-called
        portrayal_method: Callable[[Agent], Dict[Any, Any]],
        canvas_width: int,
        canvas_height: int
        ):
        self._portrayal_method = portrayal_method
        self.canvas_height = canvas_height
        self.canvas_width = canvas_width
        self.js_code = (
            "import {Simple_3d_Continuous_Module} from './local/frc/simple_3d_continuous_canvas.js';\n"
            "elements.push(new Simple_3d_Continuous_Module());"
        )

    def render(self, model: Model) -> List[Any]:
        space_state = []
        for obj in model.schedule.agents:
            portrayal = self._portrayal_method(obj)
            p = obj.pos
            portrayal["x"] = p[0]
            portrayal["y"] = p[1]
            portrayal["z"] = p[2]
            space_state.append(portrayal)
        return space_state
