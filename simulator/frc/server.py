"""
Sets up the visualization; uses SimpleCanvas.
"""

from mesa.visualization.ModularVisualization import ModularServer
from mesa import Agent

from .agents import Cargo, Robot
from .model import RobotFlockers
from .SimpleContinuousModule import SimpleCanvas

def robot_draw(agent: Agent):
    if agent is None:
        pass
    elif isinstance(agent, Cargo):
        return {"Shape": "circle",
            "r": 12, # cm?
            "Filled": "true",
            "Color": "Red" # TODO: coloring
        }
    elif isinstance(agent, Robot):
        return {
            "Shape": "circle", # TODO: make square like the shape example
            "r": 50, # is this cm?
            "Filled": "true",
            "Color": "Red" # TODO: coloring
        } 
    print(f"bad agent id {agent.unique_id}")
    pass


#robot_canvas = SimpleCanvas(robot_draw, 800, 800)
robot_canvas = SimpleCanvas(robot_draw, 823, 1646)
model_params = {
    "population": 6, # remove this
    "width": 16.46, # overrides the params in the model
    "height": 8.23,
    "speed": 0.1,
    "vision": 20,
    "separation": 2,
}

server = ModularServer(RobotFlockers, [robot_canvas], "Robots", model_params)
