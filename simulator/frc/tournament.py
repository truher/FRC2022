import numpy as np
import random
import matplotlib.pyplot as plt
import multiprocessing
from typing import Tuple
from mesa import Model, Agent
from mesa.time import RandomActivation
from mesa.space import Grid
from mesa.datacollection import DataCollector
from mesa.batchrunner import BatchRunnerMP

class Player(Agent):
    def __init__(self, id, skill):
        self.unique_id = id
        self.skill = skill
    def step(self):
        pass
    def score(self):
        return random.lognormvariate(self.skill, 0.6) # skill only matters a little

def red_score(m: Model):
    return m.red_score
def blue_score(m: Model):
    return m.blue_score

class Tournament(Model):
    def __init__(self, matchup: Tuple[Player]):
        self.schedule = RandomActivation(self)
        # by tick
        self.datacollector = DataCollector(model_reporters={ "red_score1": red_score, "blue_score1": blue_score})
        self.red_players = matchup[0:3]
        self.blue_players = matchup[3:6]
        for p in matchup:
            self.schedule.add(p)
        self.red_score = 0
        self.blue_score = 0
        self.running = True
        self.datacollector.collect(self)

    def step(self):
        self.schedule.step()
        for p in self.red_players:
            self.red_score += p.score()
        for p in self.blue_players:
            self.blue_score += p.score()
        self.datacollector.collect(self)
        if self.schedule.steps > 50:
            self.running = False

def run():
    teams = [Player(i, i/58) for i in range(0,59)] # SVL2019 had 59 teams
    matches = range(0,89) # SVL2019 had 89 quals
    matchups = [tuple(random.sample(teams, 6)) for i in matches] # tuple is hashable
    fixed_params = None
    variable_params = {'matchup': matchups}
    model_reporter = {'red_score': lambda m: m.red_score, 'blue_score': lambda m: m.blue_score}
    # each run is one simulated regional
    param_run = BatchRunnerMP(
        Tournament,
        nr_processes = 5,
        variable_parameters=variable_params,
        fixed_parameters=fixed_params,
        iterations=10,
        max_steps=1000,
        model_reporters=model_reporter
    )
    param_run.run_all()
    df = param_run.get_model_vars_dataframe()
    plt.scatter(df.red_score, df.blue_score)
    plt.show()
    df['red_teams'] = df['matchup'].apply(lambda x: x[0:3])
    df['blue_teams'] = df['matchup'].apply(lambda x: x[3:6])
    df = df.explode('red_teams').explode('blue_teams')
    df['red_skill'] = df['red_teams'].apply(lambda x: x.skill)
    df['blue_skill'] = df['blue_teams'].apply(lambda x: x.skill)
    plt.scatter(df.red_skill, df.red_score)
    plt.show()
    plt.scatter(df.blue_skill, df.blue_score)
    plt.show()
    df['red_win'] = (df.red_score>df.blue_score).apply(lambda x: int(x))
    df['blue_win'] = (df.blue_score>df.red_score).apply(lambda x: int(x))
    df['red_skill_rounded'] = round(df['red_skill'], 1)
    df['blue_skill_rounded'] = round(df['blue_skill'], 1)
    red = df.groupby(by='red_skill_rounded', as_index=False).mean()[['red_skill_rounded','red_win']]
    blue = df.groupby(by='blue_skill_rounded', as_index=False).mean()[['blue_skill_rounded','blue_win']]
    
    plt.scatter(red.red_skill_rounded, red.red_win)
    plt.xlabel('skill')
    plt.ylabel('probability of win')
    plt.title('red')
    plt.show()
    plt.scatter(blue.blue_skill_rounded, blue.blue_win)
    plt.xlabel('skill')
    plt.ylabel('probability of win')
    plt.title('blue')
    plt.show()

if __name__ == '__main__':
    """ main is required to avoid mp deadlock """
    multiprocessing.freeze_support()
    multiprocessing.set_start_method('forkserver')
    run()
