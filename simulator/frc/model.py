"""
The model instantiates the environment.

Uses numpy arrays to represent vectors.
"""

import numpy as np

from mesa import Model
from mesa.space import ContinuousSpace
from mesa.time import RandomActivation

from .robot import Robot


class RobotFlockers(Model):
    """
    Flocker model class. Handles agent creation, placement and scheduling.
    """

    def __init__(
        self,
        population=100,
        width=16.46, # landscape orientation
        height=8.23,
        speed=0.2,
        vision=20,
        separation=2,
        cohere=0.1,
        separate=0.4,
        match=0.2,
    ):
        """
        Create a new Flockers model.

        Args:
            population: Number of robots
            width, height: Size of the space in meters.
            speed: How fast should the robots move.
            vision: How far around should each robot look for its neighbors
            separation: What's the minimum distance each robot will attempt to
                    keep from any other
            cohere, separate, match: factors for the relative importance of
                    the three drives."""
        self.population = population
        self.vision = vision
        self.speed = speed
        self.separation = separation
        self.schedule = RandomActivation(self)
        self.space = ContinuousSpace(width, height, False) # not toroidal
        self.factors = dict(cohere=cohere, separate=separate, match=match)
        self.make_agents()
        self.running = True

    def make_agents(self):
        """
        Create self.population agents, with random positions and starting headings.
        """
        print(self.space.x_max)
        print(self.space.y_max)
        for i in range(self.population):
            x = self.random.random() * self.space.x_max
            y = self.random.random() * self.space.y_max
            pos = np.array((x, y))
            # TODO make this intrinsic
            velocity = np.random.random(2) * 2 - 1
            robot = Robot(
                i,
                self,
                pos,
                self.speed,
                velocity,
                self.vision,
                self.separation,
                **self.factors
            )
            self.space.place_agent(robot, pos)
            self.schedule.add(robot)

    def step(self):
        self.schedule.step()
