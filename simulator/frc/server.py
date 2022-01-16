from mesa.visualization.ModularVisualization import ModularServer
from mesa.visualization.modules import BarChartModule, ChartModule, TextElement
from mesa import Agent
import numpy as np

from .agents import Cargo, Robot
from .alliance import Alliance
from .model import CalRobotFlockers, RobotFlockers
from .SimpleContinuousModule import SimpleCanvas

def robot_draw(agent: Agent) -> dict:
    if isinstance(agent, Cargo):
        return {
            "Shape": "cargo",
            "color": agent.alliance.color
        }
    if isinstance(agent, Robot):
        return {
            "Shape": "robot",
            "w": 2*agent.radius_m/16.46, # unit = fraction of the field FIXME
            "h": 2*agent.radius_m/8.23,
            "angle": np.arctan2(agent._velocity[1], agent._velocity[0]),
            "color": agent.alliance.color,
            "slot1": agent.slot1.alliance.color if agent.slot1 else Alliance.NULL.color,
            "slot2": agent.slot2.alliance.color if agent.slot1 else Alliance.NULL.color
        }
    return {
        "Shape": "circle",
        "r": agent.radius_m * 100, # FIXME assumes canvas size
        "color": "gray"
    }

class SomeText(TextElement):
    def render(self, model):
        time = model.datacollector.model_vars['time'][-1]
        minutes = time // 60
        seconds = time % 60
        return f"Model time: {minutes:.0f}:{seconds:05.2f}"


robot_canvas = SimpleCanvas(robot_draw, 1646, 823)
speed_chart = ChartModule(
    [
        {"Label": "mean_speed", "Color": "red"}
    ]
)
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
model_params = {
}

server = ModularServer(
    RobotFlockers, [robot_canvas, text_element], "Robots", model_params
    #CalRobotFlockers, [robot_canvas, text_element, speed_chart], "Robots", model_params
)
