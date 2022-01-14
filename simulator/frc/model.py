import numpy as np
from mesa import Model
from mesa.space import ContinuousSpace
from mesa.time import SimultaneousActivation
from .agents import Cargo, Obstacle, Robot
from .alliance import Alliance
from .collision import overlap

X_MAX_M = 16.46
Y_MAX_M = 8.23

class RobotFlockers(Model):
    def __init__(self):
        self.schedule = SimultaneousActivation(self)
        self.space = ContinuousSpace(X_MAX_M, Y_MAX_M, False) # 16x8 meters, not toroidal
        self.make_agents()
        self.running = True

    def is_overlapping(self, pos, r) -> bool:
        for a in self.space._agent_to_index.keys():
            if overlap(pos, a.pos, r, a.radius_m):
                #print(f"overlap {pos} {a.pos}")
                return True
        return False

    def make_agents(self):
        # a center obstacle
        ctr = np.array((X_MAX_M/2, Y_MAX_M/2))
        obstacle = Obstacle(300, self, ctr)
        obstacle.radius_m = 1.72
        #obstacle.mass_kg = np.inf # ???
        #obstacle._velocity = np.zeros(2)
        # the normal calcs don't work with infinite mass.
        self.space.place_agent(obstacle, ctr)
        self.schedule.add(obstacle)

        counter = 1000
        for xx in np.arange(0+0.01, X_MAX_M-0.01, 0.5):
            for yy in [0.01, Y_MAX_M-0.01]:
                counter += 1
                pos = np.array((xx, yy))
                #print(f"counter {counter} pos {pos}")
                obstacle = Obstacle(counter, self, pos)
                obstacle.radius_m = 0.01
                self.space.place_agent(obstacle, pos)
                self.schedule.add(obstacle)
 
        for xx in [0.01, X_MAX_M-0.01]:
            for yy in np.arange(0+0.01, Y_MAX_M-0.01, 0.5):
                counter += 1
                pos = np.array((xx, yy))
                #print(f"counter {counter} pos {pos}")
                obstacle = Obstacle(counter, self, pos)
                obstacle.radius_m = 0.01
                self.space.place_agent(obstacle, pos)
                self.schedule.add(obstacle)
 






        # red robots
        for i in range(0, 3):
            while True: # avoid overlap
                x = self.space.x_max / 2 + 2 + self.random.random() * (self.space.x_max/2 - 3)
                y = 1 + self.random.random() * (self.space.y_max - 2)
                pos = np.array((x, y))
                #print(f"i {i} pos {pos}")
                if not self.is_overlapping(pos, 0.5):
                    break
            robot = Robot( i, self, pos, Alliance.RED)
            robot._velocity = np.random.normal(loc=0.00, scale=0.5, size=2)
            self.space.place_agent(robot, pos)
            self.schedule.add(robot)

        # blue robots
        for i in range(10, 13):
            while True: # avoid overlap
                x = 1 + self.random.random() * (self.space.x_max/2 - 3)
                y = 1 + self.random.random() * (self.space.y_max - 2)
                pos = np.array((x, y))
                if not self.is_overlapping(pos, 0.5):
                    break
            #print(f"i {i} pos {pos}")
            robot = Robot( i, self, pos, Alliance.BLUE)
            robot._velocity = np.random.normal(loc=0.00, scale=0.5, size=2)
            self.space.place_agent(robot, pos)
            self.schedule.add(robot)

        # red cargo
        for i in range(100,111):
            while True: # avoid overlap
                x = 1 + self.random.random() * (self.space.x_max - 2)
                y = 1 + self.random.random() * (self.space.y_max - 2)
                pos = np.array((x, y))
                if not self.is_overlapping(pos, 0.12):
                    break
            #print(f"i {i} pos {pos}")
            cargo = Cargo(i, self, pos, Alliance.RED)
            self.space.place_agent(cargo, pos)
            self.schedule.add(cargo)

        # blue cargo
        for i in range(200,211):
            while True: # avoid overlap
                x = 1 + self.random.random() * (self.space.x_max - 2)
                y = 1 + self.random.random() * (self.space.y_max - 2)
                pos = np.array((x, y))
                if not self.is_overlapping(pos, 0.12):
                    break
            #print(f"i {i} pos {pos}")
            cargo = Cargo(i, self, pos, Alliance.BLUE)
            self.space.place_agent(cargo, pos)
            self.schedule.add(cargo)

    def step(self):
        self.schedule.step()
