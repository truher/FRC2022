import numpy as np
from mesa import Agent
from .alliance import Alliance

class Cargo(Agent):
    def __init__(self, unique_id: int, model: 'Model',
        pos,
        alliance: Alliance,
    ) -> None:
        super().__init__(unique_id, model)
        self.pos = np.array(pos)
        self.alliance: Alliance = alliance
        self.radius_m = 0.12
        self.mass_kg = 0.27
        self._speed = 0.1
        self._velocity = np.random.random(2) * 2 - 1

    def step(self):
        new_pos = self.pos + self._velocity * self._speed
        x, y = new_pos
        if x < 0 or x >= self.model.space.width:
            self._velocity *= [-1,1]
        if y < 0 or y >= self.model.space.height:
            self._velocity *= [1,-1]
        new_pos = self.pos + self._velocity * self._speed
        self.model.space.move_agent(self, new_pos)

class Robot(Agent):
    def __init__(self, unique_id: int, model: 'Model',
        pos,
        alliance: Alliance,
        vision,
        separation,
        cohere=0.025,
        separate=0.25,
        match=0.04,
    ):
        super().__init__(unique_id, model)
        self.pos = np.array(pos)
        self.radius_m = 0.50
        self.mass_kg = 56 # max allowed
        self.alliance: Alliance = alliance
        self._speed = 0.1
        self._velocity = np.random.random(2) * 2 - 1
        self.vision = vision
        self.separation = separation
        self.cohere_factor = cohere
        self.separate_factor = separate
        self.match_factor = match

    def cohere(self, neighbors):
        cohere = np.zeros(2)
        if neighbors:
            for neighbor in neighbors:
                cohere += self.model.space.get_heading(self.pos, neighbor.pos)
            cohere /= len(neighbors)
        return cohere

    def separate(self, neighbors):
        me = self.pos
        them = (n.pos for n in neighbors)
        separation_vector = np.zeros(2)
        for other in them:
            if self.model.space.get_distance(me, other) < self.separation:
                separation_vector -= self.model.space.get_heading(me, other)
        return separation_vector

    def match_heading(self, neighbors):
        match_vector = np.zeros(2)
        if neighbors:
            for neighbor in neighbors:
                match_vector += neighbor._velocity
            match_vector /= len(neighbors)
        return match_vector

    def step(self):
        neighbors = self.model.space.get_neighbors(self.pos, self.vision, False)
        self._velocity += np.random.normal(loc=0.00, scale=0.05, size=2)
        #self._velocity += (
        #    self.cohere(neighbors) * self.cohere_factor
        #    + self.separate(neighbors) * self.separate_factor
        #    + self.match_heading(neighbors) * self.match_factor
        #) / 2
        self._velocity /= np.linalg.norm(self._velocity)
        new_pos = self.pos + self._velocity * self._speed
        x, y = new_pos
        if x < 0 or x >= self.model.space.width:
            self._velocity *= [-1,1]
        if y < 0 or y >= self.model.space.height:
            self._velocity *= [1,-1]
        new_pos = self.pos + self._velocity * self._speed
        self.model.space.move_agent(self, new_pos)
