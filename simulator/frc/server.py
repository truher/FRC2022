"""
Sets up the visualization; uses SimpleCanvas.
"""

from mesa.visualization.ModularVisualization import ModularServer

from .model import RobotFlockers
from .SimpleContinuousModule import SimpleCanvas


def robot_draw(agent):
    return {"Shape": "circle", "r": 20, "Filled": "true", "Color": "Red"}


#robot_canvas = SimpleCanvas(robot_draw, 800, 800)
robot_canvas = SimpleCanvas(robot_draw, 823, 1646)
model_params = {
    "population": 6,
    "width": 16.46, # overrides the params in the model
    "height": 8.23,
    "speed": 0.1,
    "vision": 20,
    "separation": 2,
}

server = ModularServer(RobotFlockers, [robot_canvas], "Robots", model_params)
