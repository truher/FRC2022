import numpy as np

from mesa import Agent


class Robot(Agent):
    """
    An FRC robot.
    """

    def __init__(
        self,
        unique_id,
        model,
        pos,
        speed,
        velocity,
        vision,
        separation,
        cohere=0.025,
        separate=0.25,
        match=0.04,
    ):
        """
        Args:
            unique_id: Unique agent identifyer.
            pos: Starting position
            speed: Distance to move per step.
            heading: numpy vector for the robot's direction of movement.
            vision: Radius to look around for nearby robots.
            separation: Minimum distance to maintain from other robots.
            cohere: the relative importance of matching neighbors' positions
            separate: the relative importance of avoiding close neighbors
            match: the relative importance of matching neighbors' headings

        """
        super().__init__(unique_id, model)
        self.pos = np.array(pos)
        self.speed = speed
        self._velocity = velocity # friend
        self.vision = vision
        self.separation = separation
        self.cohere_factor = cohere
        self.separate_factor = separate
        self.match_factor = match

    def cohere(self, neighbors):
        """
        Return the vector toward the center of mass of the local neighbors.
        """
        cohere = np.zeros(2)
        if neighbors:
            for neighbor in neighbors:
                cohere += self.model.space.get_heading(self.pos, neighbor.pos)
            cohere /= len(neighbors)
        return cohere

    def separate(self, neighbors):
        """
        Return a vector away from any neighbors closer than separation dist.
        """
        me = self.pos
        them = (n.pos for n in neighbors)
        separation_vector = np.zeros(2)
        for other in them:
            if self.model.space.get_distance(me, other) < self.separation:
                separation_vector -= self.model.space.get_heading(me, other)
        return separation_vector

    def match_heading(self, neighbors):
        """
        Return a vector of the neighbors' average heading.
        """
        match_vector = np.zeros(2)
        if neighbors:
            for neighbor in neighbors:
                match_vector += neighbor._velocity
            match_vector /= len(neighbors)
        return match_vector

    def step(self):
        """
        Just move randomly
        Get the robot's neighbors, compute the new vector, and move accordingly.
        """

        neighbors = self.model.space.get_neighbors(self.pos, self.vision, False)
        self._velocity += np.random.normal(loc=0.01, scale=0.01, size=2)
        #self._velocity += (
        #    self.cohere(neighbors) * self.cohere_factor
        #    + self.separate(neighbors) * self.separate_factor
        #    + self.match_heading(neighbors) * self.match_factor
        #) / 2
        self._velocity /= np.linalg.norm(self._velocity)
        new_pos = self.pos + self._velocity * self.speed
        x, y = new_pos
        if x < 0 or x >= self.model.space.width:
            self._velocity *= [-1,1]
        if y < 0 or y >= self.model.space.height:
            self._velocity *= [1,-1]
        new_pos = self.pos + self._velocity * self.speed
        self.model.space.move_agent(self, new_pos)
        
        # just stop on the edge
        # TODO: something more clever, reflect? flinch?
        
        #if not self.model.space.out_of_bounds(new_pos):
        #     self.model.space.move_agent(self, new_pos)
