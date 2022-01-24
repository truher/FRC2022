import multiprocessing
import random
from enum import Enum
from typing import List, Tuple
import pandas as pd #  type:ignore
import matplotlib.pyplot as plt #  type:ignore
from mesa import Model, Agent #  type:ignore
from mesa.time import BaseScheduler, RandomActivation #  type:ignore
from mesa.datacollection import DataCollector #  type:ignore
from mesa.batchrunner import BatchRunnerMP #  type:ignore

class Rung(Enum):
    LOW = (4)
    MID = (6)
    HIGH = (10)
    TRAVERSAL = (15)
    def __init__(self, points):
        self.points = points

class Player(Agent):
    def __init__(self, unique_id: int, model: Model, skill: float, climb_skill: Rung) -> None:
        super().__init__(unique_id, model)
        self.skill = skill
        self.climb_skill = climb_skill

    def step(self):
        pass

    def score(self) -> int:
        return int(10 * random.lognormvariate(self.skill, 0.6)) # skill only matters a little

def red_score(m: Model) -> int:
    return m.red_score
def blue_score(m: Model) -> int:
    return m.blue_score

class Tournament(Model):
    def __init__(self, matchup: Tuple[Player, Player, Player, Player, Player, Player]) -> None:
        super().__init__()
        self.schedule: BaseScheduler = RandomActivation(self)
        # by tick
        self.datacollector: DataCollector = DataCollector(
            model_reporters={
               "red_score1": red_score,
               "blue_score1": blue_score
           }
        )
        self.red_players: Tuple[Player, Player, Player] = matchup[:3]
        self.blue_players: Tuple[Player, Player, Player] = matchup[3:]
        for p in matchup:
            p.model = self
            self.schedule.add(p)
        self.red_ball_score: int = 0
        self.blue_ball_score: int = 0
        self.red_cargo_bonus: int = 0
        self.blue_cargo_bonus: int = 0
        self.red_hang_score: int = 0
        self.blue_hang_score: int = 0
        self.datacollector.collect(self)

    def step(self) -> None:
        self.schedule.step()
        for p in self.red_players:
            self.red_ball_score += p.score()
        if self.red_ball_score > 20:
            self.red_cargo_bonus = 1
        for p in self.blue_players:
            self.blue_ball_score += p.score()
        if self.blue_ball_score > 20:
            self.blue_cargo_bonus = 1
        self.datacollector.collect(self)
        if self.schedule.steps > 50:
            # finished; calculate hang scores
            self.red_hang_score = 0
            for p in self.red_players:
                self.red_hang_score += p.climb_skill.points
            self.blue_hang_score = 0
            for p in self.blue_players:
                self.blue_hang_score += p.climb_skill.points
            self.running = False

    def red_score(self) -> int:
        return self.red_ball_score + self.red_hang_score
    def blue_score(self) -> int:
        return self.blue_ball_score + self.blue_hang_score
    def red_hangar_bonus(self) -> int:
        return int(self.red_hang_score >= 16)
    def blue_hangar_bonus(self) -> int:
        return int(self.blue_hang_score >= 16)
    def red_tie(self) -> int:
        return int(self.red_score() == self.blue_score())
    def blue_tie(self) -> int:
        return int(self.red_score() == self.blue_score())
    def red_win(self) -> int:
        return int(self.red_score() > self.blue_score())
    def blue_win(self) -> int:
        return int(self.blue_score() > self.red_score())
    def red_rp(self) -> int:
        return self.red_cargo_bonus + self.red_hangar_bonus() + self.red_tie() + 2 * self.red_win()
    def blue_rp(self) -> int:
        return self.blue_cargo_bonus + self.blue_hangar_bonus() + self.blue_tie() + 2 * self.blue_win()
    def matchup_cargo_bonus(self) -> List[int]:
        return [*[self.red_cargo_bonus for _ in range(0,3)],
                *[self.blue_cargo_bonus for _ in range(0,3)]]
    def matchup_hangar_bonus(self) -> List[int]:
        return [*[self.red_hangar_bonus() for _ in range(0,3)],
                *[self.blue_hangar_bonus() for _ in range(0,3)]]
    def matchup_ties(self) -> List[int]:
        return [*[self.red_tie() for _ in range(0,3)],
                *[self.blue_tie() for _ in range(0,3)]]
    def matchup_wins(self) -> List[int]:
        return [*[self.red_win() for _ in range(0,3)],
                *[self.blue_win() for _ in range(0,3)]]
    def matchup_rp(self) -> List[int]:
        return [*[self.red_rp() for _ in range(0,3)],
                *[self.blue_rp() for _ in range(0,3)]]
    def matchup_point_delta(self) -> List[int]:
        return [*[self.red_score() - self.blue_score() for _ in range(0,3)],
                *[self.blue_score() - self.red_score() for _ in range(0,3)]]
    def matchup_rp_delta(self) -> List[int]:
        return [*[self.red_rp() - self.blue_rp() for _ in range(0,3)],
                *[self.blue_rp() - self.red_rp() for _ in range(0,3)]]

def run():
    # each run is one simulated regional
    df = pd.DataFrame()
    for regional in range(0,50):
        print(f"regional {regional}")
        teams = [Player(i, None, i/58, random.choice(list(Rung))) for i in range(0,59)] # SVL2019 had 59 teams
        matches = range(0,89) # SVL2019 had 89 quals
        matchups = [tuple(random.sample(teams, 6)) for i in matches] # tuple is hashable
        fixed_params = None
        variable_params = {'matchup': matchups}
        model_reporter = {
            'red_score': Tournament.red_score,
            'blue_score': Tournament.blue_score,
            'matchup_wins': Tournament.matchup_wins,
            'matchup_rp': Tournament.matchup_rp,
            'matchup_point_delta': Tournament.matchup_point_delta,
            'matchup_rp_delta': Tournament.matchup_rp_delta
        }
        param_run = BatchRunnerMP(
            Tournament,
            nr_processes = 5,
            variable_parameters=variable_params,
            fixed_parameters=fixed_params,
            iterations=1,
            max_steps=1000,
            model_reporters=model_reporter
        )
        param_run.run_all()
        df = pd.concat([df, param_run.get_model_vars_dataframe()])

    df['matchup_skill'] = df['matchup'].apply(lambda x: [p.skill for p in x])
    df['matchup_climb_skill'] = df['matchup'].apply(lambda x: [p.climb_skill.value for p in x])

    plt.scatter(df.red_score, df.blue_score)
    plt.xlabel('red score')
    plt.ylabel('blue score')
    plt.title('scores')
    plt.show()

    df = df.drop('matchup', axis=1)
    df = df.explode(['matchup_wins','matchup_rp','matchup_point_delta',
                     'matchup_rp_delta','matchup_skill','matchup_climb_skill'])
    # explode yields objects not numbers, so convert
    df = df.apply(pd.to_numeric)

    plt.scatter(df.matchup_skill, df.matchup_point_delta)
    plt.xlabel('skill')
    plt.ylabel('point delta')
    plt.title('point delta by skill')
    plt.show()

    point_delta_by_climb_skill = (
        df.groupby(by='matchup_climb_skill', as_index=False)['matchup_point_delta']
        .agg(['mean','std'])
        .reset_index()
    )
    plt.errorbar(
        x=point_delta_by_climb_skill['matchup_climb_skill'],
        y=point_delta_by_climb_skill['mean'],
        yerr=point_delta_by_climb_skill['std'],
        fmt='o'
    )
    plt.xlabel('climb_skill')
    plt.ylabel('mean point delta')
    plt.title('mean point delta by climb skill')
    plt.show()

    df['skill_rounded'] = df['matchup_skill'].apply(lambda x: round(x, 1))
    summary = df.groupby(by='skill_rounded', as_index=False).mean()

    plt.scatter(summary.skill_rounded, summary.matchup_wins)
    plt.xlabel('skill')
    plt.ylabel('probability of win')
    plt.title('p(win) by skill')
    plt.show()

    plt.scatter(summary.skill_rounded, summary.matchup_point_delta)
    plt.xlabel('skill')
    plt.ylabel('point delta')
    plt.title('point delta by skill')
    plt.show()

    plt.scatter(summary.skill_rounded, summary.matchup_rp_delta)
    plt.xlabel('skill')
    plt.ylabel('ranking point delta')
    plt.title('ranking point delta by skill')
    plt.show()

if __name__ == '__main__':
    # main is required to avoid mp deadlock
    multiprocessing.freeze_support()
    multiprocessing.set_start_method('forkserver')
    run()
