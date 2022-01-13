import numpy as np
from mesa import Model
from mesa.space import ContinuousSpace
from mesa.time import SimultaneousActivation
from .agents import Cargo, Robot
from .alliance import Alliance


class RobotFlockers(Model):
    def __init__(
        self,
        vision=20,
        separation=2,
        cohere=0.1,
        separate=0.4,
        match=0.2,
    ):
        """
        Create a new Flockers model.

        Args:
            vision: How far around should each robot look for its neighbors
            separation: What's the minimum distance each robot will attempt to
                    keep from any other
            cohere, separate, match: factors for the relative importance of
                    the three drives."""
        self.vision = vision
        self.separation = separation
        self.schedule = SimultaneousActivation(self)
        self.space = ContinuousSpace(16.46, 8.23, False) # 16x8 meters, not toroidal
        self.factors = dict(cohere=cohere, separate=separate, match=match)
        self.make_agents()
        self.running = True

    def make_agents(self):
        for i in range(0, 3):
            x = self.random.random() * self.space.x_max
            y = self.random.random() * self.space.y_max
            pos = np.array((x, y))
            robot = Robot(
                i,
                self,
                pos,
                Alliance.RED,
                self.vision,
                self.separation,
                **self.factors
            )
            self.space.place_agent(robot, pos)
            self.schedule.add(robot)


        for i in range(10, 13):
            x = self.random.random() * self.space.x_max
            y = self.random.random() * self.space.y_max
            pos = np.array((x, y))
            robot = Robot(
                i,
                self,
                pos,
                Alliance.BLUE,
                self.vision,
                self.separation,
                **self.factors
            )
            self.space.place_agent(robot, pos)
            self.schedule.add(robot)

        for i in range(100,111):
            x = self.random.random() * self.space.x_max
            y = self.random.random() * self.space.y_max
            pos = np.array((x, y))
            cargo = Cargo(i, self, pos, Alliance.RED)
            self.space.place_agent(cargo, pos)
            self.schedule.add(cargo)

        for i in range(200,211):
            x = self.random.random() * self.space.x_max
            y = self.random.random() * self.space.y_max
            pos = np.array((x, y))
            cargo = Cargo(i, self, pos, Alliance.BLUE)
            self.space.place_agent(cargo, pos)
            self.schedule.add(cargo)

    def step(self):
        self.schedule.step()
