import numpy as np
from mesa import Model
from mesa.space import ContinuousSpace
from mesa.time import RandomActivation
from mesa.datacollection import DataCollector
from .agents import Cargo, Obstacle, Robot
from .alliance import Alliance
from .collision import overlap

X_MAX_M = 16.46
Y_MAX_M = 8.23

#def get_step(model):
#    x = model.model_steps
#    return x

class RobotFlockers(Model):
    def __init__(self):
        self.schedule = RandomActivation(self)
        self.space = ContinuousSpace(X_MAX_M, Y_MAX_M, False) # 16x8 meters, not toroidal
        self.make_agents()
        # datacollector member is needed for charts
        self.datacollector = DataCollector(
            model_reporters = { # key: variable name, value: function
                "time": lambda m: m.model_time,
                "mean_speed": lambda m: m.mean_speed
            },
            agent_reporters = {
                "speed": lambda a: a.speed # time series doesn't work for agent data
            }
        )
        self.running = True
        self.datacollector.collect(self)

    @property
    def mean_speed(self):
        return np.mean(list(a.speed for a in self.schedule.agents))

    @property
    def model_steps(self):
        return self.schedule.steps

    @property
    def seconds_per_step(self):
        return 0.05

    @property
    def model_time(self):
        return self.model_steps * self.seconds_per_step

    def is_overlapping(self, pos, r) -> bool:
        for a in self.space._agent_to_index.keys():
            if overlap(pos, a.pos, r, a.radius_m):
                return True
        return False

    def place_obstacle(self, i, pos, radius_m):
        obstacle = Obstacle(i, self, pos)
        obstacle.radius_m = radius_m
        self.space.place_agent(obstacle, pos)
        self.schedule.add(obstacle)

    def place_robot(self, i, pos, alliance):
        robot = Robot(i, self, pos, alliance)
        robot._velocity = np.random.normal(loc=0.00, scale=0.5, size=2)
        self.space.place_agent(robot, pos)
        self.schedule.add(robot)

    def place_cargo(self, i, pos, alliance):
        cargo = Cargo(i, self, pos, alliance)
        cargo._velocity = np.random.normal(loc=0.00, scale=0.5, size=2)
        self.space.place_agent(cargo, pos)
        self.schedule.add(cargo)

    def make_agents(self):
        # the hub
        ctr = np.array((X_MAX_M/2, Y_MAX_M/2))
        self.place_obstacle(300, ctr, 1.72)

        # blue hangar upper left
        H_R = 0.2 # post radius 20cm
        H_X = 3.07 # x dimension 3.07m
        H_Y = 2.75 # y dimension 2.75m
        self.place_obstacle(2000, (H_R, H_R), H_R)
        self.place_obstacle(2001, (H_X - H_R, H_R), H_R)
        self.place_obstacle(2002, (H_X - H_R, H_Y - H_R), H_R)
        self.place_obstacle(2003, (H_R, H_Y - H_R), H_R)

        # red hangar lower right
        self.place_obstacle(2004, (X_MAX_M - H_R, Y_MAX_M - H_R), H_R)
        self.place_obstacle(2005, (X_MAX_M - H_X + H_R, Y_MAX_M - H_R), H_R)
        self.place_obstacle(2006, (X_MAX_M - H_X + H_R, Y_MAX_M - H_Y + H_R), H_R)
        self.place_obstacle(2007, (X_MAX_M - H_R, Y_MAX_M - H_Y + H_R), H_R)

        T_R = 0.0225 # post diameter m
        T_D = 1.75 # X and Y extent m
        i = 3000
        for p in np.linspace(T_R, T_D-T_R, 6):
            # blue terminal lower left
            self.place_obstacle(i, (p, Y_MAX_M - T_D + p), T_R)
            i += 1
            # red terminal upper right
            self.place_obstacle(i, (X_MAX_M -T_D + p, p), T_R)
            i += 1
 
        # red robots
        for i in range(0, 3):
            while True: # avoid overlap
                x = self.space.x_max / 2 + 2 + self.random.random() * (self.space.x_max/2 - 3)
                y = 1 + self.random.random() * (self.space.y_max - 2)
                pos = np.array((x, y))
                if not self.is_overlapping(pos, 0.5):
                    break
            self.place_robot(i, pos, Alliance.RED)

        # blue robots
        for i in range(10, 13):
            while True: # avoid overlap
                x = 1 + self.random.random() * (self.space.x_max/2 - 3)
                y = 1 + self.random.random() * (self.space.y_max - 2)
                pos = np.array((x, y))
                if not self.is_overlapping(pos, 0.5):
                    break
            self.place_robot(i, pos, Alliance.BLUE)

        # red cargo
        for i in range(100,111):
            while True: # avoid overlap
                x = 1 + self.random.random() * (self.space.x_max - 2)
                y = 1 + self.random.random() * (self.space.y_max - 2)
                pos = np.array((x, y))
                if not self.is_overlapping(pos, 0.12):
                    break
            self.place_cargo(i, pos, Alliance.RED)

        # blue cargo
        for i in range(200,211):
            while True: # avoid overlap
                x = 1 + self.random.random() * (self.space.x_max - 2)
                y = 1 + self.random.random() * (self.space.y_max - 2)
                pos = np.array((x, y))
                if not self.is_overlapping(pos, 0.12):
                    break
            self.place_cargo(i, pos, Alliance.BLUE)

    def step(self):
        self.schedule.step()
        self.datacollector.collect(self)


# to calibrate ball movement
# spreadsheet simulation says initial 2m/s should stop at about 13m after about 15s.
# ... and this matches!  yay!
class CalRobotFlockers(RobotFlockers):
    # override
    def make_agents(self):
        # one ball with initial velocity
        pos = np.array([1, Y_MAX_M/2])
        cargo = Cargo(0, self, pos, Alliance.BLUE)
        cargo._velocity = np.array([2, 0])
        self.space.place_agent(cargo, pos)
        self.schedule.add(cargo)
