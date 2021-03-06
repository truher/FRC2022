from typing import Any, Dict
from mesa.visualization.ModularVisualization import ModularServer # type: ignore
from mesa.visualization.modules import TextElement # type: ignore
from mesa import Agent, Model # type: ignore
import numpy as np

from .agent import Cargo, Robot, Obstacle
from .alliance import Alliance
#from .model import CalRobotFlockers, CalV, RobotFlockers
from .model import RobotFlockers
from .SimpleContinuousModule import SimpleCanvas
from .Simple3dContinuousModule import Simple3dCanvas

# renderer scale is just meters, just like the back end
def robot_draw(agent: Agent) -> Dict[Any, Any]:
    if isinstance(agent, Cargo):
        return {
            "Shape": "cargo",
            "color": agent.alliance.color,
            #"z": agent.z_m
        }
    if isinstance(agent, Robot):
        #pylint: disable=no-member
        return {
            "Shape": "robot",
            "w": 2 * agent.radius_m,
            "h": 2 * agent.radius_m,
            "angle": np.arctan2(agent.velocity[1], agent.velocity[0]),
            "color": agent.alliance.color,
            "slot1": (Alliance.NULL.color if agent.slot1 is None
                     else agent.slot1.alliance.color),
            "slot2": (Alliance.NULL.color if agent.slot2 is None
                     else agent.slot2.alliance.color),
        }
    if isinstance(agent, Obstacle):
        return {
            "Shape": "obstacle",
            "h": agent.z_height_m,
            "r": agent.radius_m,
        }
    return {
        "Shape": "circle",
        "r": agent.radius_m,
        "color": "gray"
    }

class SomeText(TextElement): # type:ignore
    def render(self, model: Model) -> str:
        time = model.datacollector.model_vars['time'][-1]
        minutes = time // 60
        seconds = time % 60
        blue_terminal = model.datacollector.model_vars['blue_terminal_population'][-1]
        red_terminal = model.datacollector.model_vars['red_terminal_population'][-1]
        out_of_bounds = model.datacollector.model_vars['out_of_bounds_population'][-1]
        return (
            f"Model time: {minutes:.0f}:{seconds:05.2f}<br>"
            f"Blue terminal population: {blue_terminal:.0f}<br>"
            f"Red terminal population: {red_terminal:.0f}<br>"
            f"Out of bounds population: {out_of_bounds:.0f}<br>"
        )


robot_canvas = SimpleCanvas(robot_draw, 1646, 823)
robot_canvas_2 = Simple3dCanvas(robot_draw, 1646, 823)
#speed_chart = ChartModule(
#    [
#        {"Label": "mean_speed", "Color": "red"}
#    ]
#)
# this seems *really* slow, pegs chrome
#delay_chart = ChartModule(
#    [
#        {"Label": "blue_terminal_population", "Color": "blue"},
#        {"Label": "red_terminal_population", "Color": "red"}
#    ]
#)
#test_chart = ChartModule(
#    [
#        {"Label": "time", "Color": "red"}
#    ]
#)
#agent_chart = BarChartModule(
#    [
#        {"Label": "speed", "Color": "red"}
#    ],
#    scope = "agent"
#)
text_element = SomeText()
# ctor variable names
model_params: Dict[str, float] = {
}

server = ModularServer(
    #CalV, [robot_canvas, robot_canvas_2], "Robots", model_params
    #CalRobotFlockers, [robot_canvas, text_element, speed_chart], "Robots", model_params
    RobotFlockers, [robot_canvas, robot_canvas_2, text_element], "Robots", model_params
)
server.verbose = False
