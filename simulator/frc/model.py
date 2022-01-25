from typing import Optional, Tuple
import numpy as np
from mesa import Model # type: ignore
#from mesa.space import ContinuousSpace # type: ignore
from mesa.time import RandomActivation # type: ignore
from mesa.datacollection import DataCollector # type: ignore
#from numpy.typing import NDArray # no shape indicator
from .agent import Cargo, Obstacle, Robot
from .alliance import Alliance
from .collision import overlap
from .delay import Delay
from .space import Continuous3dSpace

R3 = Tuple[float, float, float]

X_MAX_M: float = 16.46
Y_MAX_M: float = 8.23

class RobotFlockers(Model): # type:ignore
    def __init__(self) -> None:
        super().__init__()
        self.schedule = RandomActivation(self)
        self.space = Continuous3dSpace((X_MAX_M, Y_MAX_M, 0), False) # 16x8 meters, not toroidal
        self.make_agents()
        # datacollector member is needed for charts
        self.datacollector = DataCollector(
            model_reporters = { # key: variable name, value: function
                "time": lambda m: m.model_time,
                "mean_speed": lambda m: m.mean_speed,
                "blue_terminal_population": lambda m: m.blue_terminal.length,
                "red_terminal_population": lambda m: m.red_terminal.length,
                "out_of_bounds_population": lambda m: m.out_of_bounds.length
            },
            agent_reporters = {
                "speed": lambda a: a.speed # time series doesn't work for agent data
            }
        )

        # terminal retrieval is a five-second task, two workers
        self.blue_terminal: Delay[Cargo] = Delay(5, 2/5)
        self.red_terminal: Delay[Cargo] = Delay(5, 2/5)
        # manual says return in 5 seconds, four shallow ramps though
        self.lower_hub: Delay[Cargo] = Delay(5, 4/5)
        # manual says return in 7 seconds, four shallow ramps though
        self.upper_hub: Delay[Cargo] = Delay(7, 4/7)

        # TODO: make wall collisions respect altitude
        # TODO: do this as four separate delays
        self.out_of_bounds: Delay[Cargo] = Delay(5, 2/5)

        self.running = True
        self.datacollector.collect(self)

    @property
    def mean_speed(self) -> float:
        return np.mean(list(a.speed for a in self.schedule.agents)) # type:ignore

    @property
    def model_steps(self) -> int:
        return self.schedule.steps # type:ignore

    @property
    def seconds_per_step(self) -> float:
        return 0.05

    @property
    def model_time(self) -> float:
        return self.model_steps * self.seconds_per_step

    def is_overlapping(self, pos: R3, r: float) -> bool:
        for a in self.space._agent_to_index: # pylint: disable=protected-access
            if overlap(pos, a.pos, r, a.radius_m):
                return True
        return False

    # TODO: lower height too, for upper hub
    def place_obstacle(self, i: int, pos: R3,
        radius_m: float, z_height_m: float) -> None:
        obstacle = Obstacle(i, self, pos, radius_m, z_height_m)
        self.space.place_agent(obstacle, pos)
        self.schedule.add(obstacle)

    def place_robot(self, i: int, pos: R3,
        alliance: Alliance) -> None:
        robot = Robot(i, self, pos, alliance)
        v = np.random.normal(loc=0.00, scale=0.5, size=2)
        robot.velocity = (v[0], v[1], 0)
        self.space.place_agent(robot, pos)
        self.schedule.add(robot)

    def place_cargo(self, i: int, pos: R3,
        alliance: Alliance) -> None:
        cargo = Cargo(i, self, pos, alliance)
        v = np.random.normal(loc=0.00, scale=0.5, size=2)
        cargo.velocity = (v[0], v[1], 0)
        self.space.place_agent(cargo, pos)
        self.schedule.add(cargo)

    def make_agents(self) -> None:
        # the hub is several obstacles
        # rotate 20 degrees ccw
        ctr: R3 = (X_MAX_M/2, Y_MAX_M/2, 0)
        # one for the lower hub and fenders
        self.place_obstacle(300, ctr, 0.86, 1.04)
        # one for the upper hub
        self.place_obstacle(301, ctr, 0.67, 2.64) # opening is 122, rim is 6
        # lower exits
        rot_rad: float = 0.35
        o_m: float = 1.36
        cos_o_m: float = o_m * np.cos(rot_rad)
        sin_o_m: float = o_m * np.sin(rot_rad)
        self.place_obstacle(302, np.add(ctr , (-sin_o_m, -cos_o_m, 0)), 0.19, 0.57)
        self.place_obstacle(303, np.add(ctr , (-cos_o_m, sin_o_m, 0)), 0.19, 0.57)
        self.place_obstacle(304, np.add(ctr , (sin_o_m, cos_o_m, 0)), 0.19, 0.57)
        self.place_obstacle(305, np.add(ctr , (cos_o_m, -sin_o_m, 0)), 0.19, 0.57)
        # posts
        p_m: float = 0.95
        cos_p_m: float = p_m * np.cos(rot_rad)
        sin_p_m: float = p_m * np.sin(rot_rad)
        self.place_obstacle(306, np.add(ctr , (-sin_p_m, -cos_p_m, 0)), 0.19, 1.71)
        self.place_obstacle(307, np.add(ctr , (-cos_p_m, sin_p_m, 0)), 0.19, 1.71)
        self.place_obstacle(308, np.add(ctr , (sin_p_m, cos_p_m, 0)), 0.19, 1.71)
        self.place_obstacle(309, np.add(ctr , (cos_p_m, -sin_p_m, 0)), 0.19, 1.71)


        # blue hangar upper left
        H_R = 0.2 # post radius 20cm
        H_X = 3.07 # x dimension 3.07m
        H_Y = 2.75 # y dimension 2.75m
        self.place_obstacle(2000, (H_R, H_R, 0), H_R, 1.88)
        self.place_obstacle(2001, (H_X - H_R, H_R, 0), H_R, 1.88)
        self.place_obstacle(2002, (H_X - H_R, H_Y - H_R, 0), H_R, 1.88)
        self.place_obstacle(2003, (H_R, H_Y - H_R, 0), H_R, 1.88)

        # red hangar lower right
        self.place_obstacle(2004, (X_MAX_M - H_R, Y_MAX_M - H_R, 0), H_R, 1.88)
        self.place_obstacle(2005, (X_MAX_M - H_X + H_R, Y_MAX_M - H_R, 0), H_R, 1.88)
        self.place_obstacle(2006, (X_MAX_M - H_X + H_R, Y_MAX_M - H_Y + H_R, 0), H_R, 1.88)
        self.place_obstacle(2007, (X_MAX_M - H_R, Y_MAX_M - H_Y + H_R, 0), H_R, 1.88)

        # terminals
        # TODO: handle the front wall and roof somehow
        T_R = 0.0225 # post radius m
        T_D = 1.75 # X and Y extent m
        i = 3000
        for p in np.linspace(T_R, T_D-T_R, 6):
            # blue terminal lower left
            self.place_obstacle(i, (p, Y_MAX_M - T_D + p, 0), T_R, 0.3)
            i += 1
            # red terminal upper right
            self.place_obstacle(i, (X_MAX_M -T_D + p, p, 0), T_R, 0.3)
            i += 1

        # red robots
        for i in range(0, 3):
            while True: # avoid overlap
                x = self.space.p_max[0] / 2 + 2 + self.random.random() * (self.space.p_max[0]/2 - 3)
                y = 1 + self.random.random() * (self.space.p_max[1] - 2)
                pos: R3 = (x, y, 0)
                if not self.is_overlapping(pos, 0.5):
                    break
            self.place_robot(i, pos, Alliance.RED)

        # blue robots
        for i in range(10, 13):
            while True: # avoid overlap
                x = 1 + self.random.random() * (self.space.p_max[0]/2 - 3)
                y = 1 + self.random.random() * (self.space.p_max[1] - 2)
                pos = (x, y, 0)
                if not self.is_overlapping(pos, 0.5):
                    break
            self.place_robot(i, pos, Alliance.BLUE)

        # red cargo
        for i in range(100,111):
            while True: # avoid overlap
                x = 1 + self.random.random() * (self.space.p_max[0] - 2)
                y = 1 + self.random.random() * (self.space.p_max[1] - 2)
                pos = (x, y, 0)
                if not self.is_overlapping(pos, 0.12):
                    break
            self.place_cargo(i, pos, Alliance.RED)

        # blue cargo
        for i in range(200,211):
            while True: # avoid overlap
                x = 1 + self.random.random() * (self.space.p_max[0] - 2)
                y = 1 + self.random.random() * (self.space.p_max[1] - 2)
                pos = (x, y, 0)
                if not self.is_overlapping(pos, 0.12):
                    break
            self.place_cargo(i, pos, Alliance.BLUE)

    def step(self) -> None:
        # move balls into terminal delays
        for item in self.space.get_neighbors((0, Y_MAX_M, 0), 1.75, False): # blue terminal
            if isinstance(item, Cargo):
                self.space.remove_agent(item)
                self.schedule.remove(item)
                self.blue_terminal.put(item, self.model_time)
        for item in self.space.get_neighbors((X_MAX_M, 0, 0), 1.75, False): # red terminal
            if isinstance(item, Cargo):
                self.space.remove_agent(item)
                self.schedule.remove(item)
                self.red_terminal.put(item, self.model_time)
        # spit out any available cargo
        # ramp potential energy is ~0.5J, which is 2m/s, probably an overestimate, but human
        # players can also add energy
        # TODO: add altitude here
        bc: Optional[Cargo] = self.blue_terminal.get(self.model_time)
        if bc is not None:
            bc.velocity = (2, -2, 0)
            bc.vz_m_s = 0
            bc.z_m = 1.57
            self.space.place_agent(bc, (2, Y_MAX_M - 2, 0))
            self.schedule.add(bc)
        rc: Optional[Cargo] = self.red_terminal.get(self.model_time)
        if rc is not None:
            rc.velocity = (-2, 2, 0)
            rc.vz_m_s = 0
            rc.z_m = 1.57
            self.space.place_agent(rc, (X_MAX_M - 2, 2, 0))
            self.schedule.add(rc)
        oc: Optional[Cargo] = self.out_of_bounds.get(self.model_time)
        if oc is not None:
            # TODO: re-enter somewhere close to where you went out
            # FIXME for now just duplicate one of the terminals
            oc.velocity = (-2, 2, 0)
            oc.vz_m_s = 0
            oc.z_m = 1.57
            self.space.place_agent(oc, (X_MAX_M - 2, 2, 0))
            self.schedule.add(oc)

        self.schedule.step()
        self.datacollector.collect(self)


# to calibrate ball movement
# spreadsheet simulation says initial 2m/s should stop at about 13m after about 15s.
# ... and this matches!  yay!
class CalRobotFlockers(RobotFlockers):
    # override
    def make_agents(self) -> None:
        # one ball with initial velocity
        pos: R3 = (1, Y_MAX_M/2, 0)
        cargo = Cargo(0, self, pos, Alliance.BLUE)
        cargo.velocity = (2, 0, 0)
        self.space.place_agent(cargo, pos)
        self.schedule.add(cargo)

class CalV(RobotFlockers):
    #override
    def make_agents(self) -> None:
        # one ball in the air, to test gravity
        pos: R3 = (1, 1, 0)
        cargo = Cargo(0, self, pos, Alliance.BLUE)
        cargo.velocity = (0, 0, 0)
        cargo.z_m = 2 # 1 meter
        self.space.place_agent(cargo, pos)
        self.schedule.add(cargo)
