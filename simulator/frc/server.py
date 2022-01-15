from mesa.visualization.ModularVisualization import ModularServer
from mesa import Agent
import numpy as np

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
            "Shape": "rect",
            "w": 2*agent.radius_m/16.46,
            "h": 2*agent.radius_m/8.23,
            "angle": np.arctan2(agent._velocity[1], agent._velocity[0]),
            #"r": agent.radius_m * 100,
            "Filled": "true",
            "Color": agent.alliance.color
        }
    return {
        "Shape": "circle",
        #"w": agent.radius_m/16.46,
        #"h": agent.radius_m/8.23,
        "r": agent.radius_m * 100,
        "Filled": "true",
        "Color": "gray"
    }
   

robot_canvas = SimpleCanvas(robot_draw, 1646, 823)
model_params = { }

server = ModularServer(RobotFlockers, [robot_canvas], "Robots", model_params)
