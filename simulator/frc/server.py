from mesa.visualization.ModularVisualization import ModularServer
from mesa import Agent

from .agents import Cargo, Robot
from .model import RobotFlockers
from .SimpleContinuousModule import SimpleCanvas

def robot_draw(agent: Agent) -> dict:
    if isinstance(agent, Cargo):
        return {
            "Shape": "circle",
            "r": agent.radius_m * 100,
            "Filled": "true",
            "Color": agent.alliance.color
        }
    if isinstance(agent, Robot):
        return {
            "Shape": "circle",
            "r": agent.radius_m * 100,
            "Filled": "true",
            "Color": agent.alliance.color
        }
    return {
        "Shape": "circle",
        "r": agent.radius_m * 100,
        "Filled": "true",
        "Color": "gray"
    }
   

robot_canvas = SimpleCanvas(robot_draw, 823, 1646)
model_params = { }

server = ModularServer(RobotFlockers, [robot_canvas], "Robots", model_params)
