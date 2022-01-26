from typing import Dict, List, Optional, Set, Tuple, Union
import numpy as np
from numpy.typing import NDArray
from mesa.agent import Agent # type:ignore

GridContent = Union[Optional[Agent], Set[Agent]]
# used in Continuous3dSpace
FloatCoordinate = Union[Tuple[float, float, float], np.ndarray]

class Continuous3dSpace:
    """Continuous space where each agent can have an arbitrary position.

    Assumes that all agents are point objects, and have a pos property storing
    their position as an (x, y, z) tuple. This class uses a numpy array internally
    to store agent objects, to speed up neighborhood lookups.

    The 3d version is similar to the 2d one but not backwards compatible.
    """

    _grid = None

    def __init__(
        self,
        p_max: Tuple[float, float, float],
        torus: bool,
        p_min: Tuple[float, float, float] = (0, 0, 0)
    ) -> None:
        """Create a new continuous space.

        Args:
            x_max, y_max: Maximum x and y coordinates for the space.
            torus: Boolean for whether the edges loop around.
            x_min, y_min: (default 0) If provided, set the minimum x and y
                          coordinates for the space. Below them, values loop to
                          the other edge (if torus=True) or raise an exception.
        """
        self.p_min = p_min
        self.p_max = p_max
        self.width = p_max[0] - p_min[0]
        self.height = p_max[1] - p_min[1]
        self.depth = p_max[2] - p_min[2]
        self.center: NDArray[np.float64] = np.array(((p_max[0] + p_min[0]) / 2,
                                                     (p_max[1] + p_min[1]) / 2,
                                                     (p_max[2] + p_min[2]) / 2))
        self.size: NDArray[np.float64] = np.array((self.width,
                                                   self.height,
                                                   self.depth))
        self.torus = torus

        self._agent_points: Optional[NDArray[np.float64]] = None
        self._index_to_agent: Dict[int, Agent] = {}
        self._agent_to_index: Dict[Agent, int] = {}

    def place_agent(self, agent: Agent, pos: FloatCoordinate) -> None:
        """Place a new agent in the space.

        Args:
            agent: Agent object to place.
            pos: Coordinate tuple for where to place the agent.
        """
        pos = self.torus_adj(pos)
        if self._agent_points is None:
            self._agent_points = np.array([pos])
        else:
            self._agent_points = np.append(self._agent_points, np.array([pos]), axis=0)
        self._index_to_agent[self._agent_points.shape[0] - 1] = agent
        self._agent_to_index[agent] = self._agent_points.shape[0] - 1
        agent.pos = pos

    def move_agent(self, agent: Agent, pos: FloatCoordinate) -> None:
        """Move an agent from its current position to a new position.

        Args:
            agent: The agent object to move.
            pos: Coordinate tuple to move the agent to.
        """
        pos = self.torus_adj(pos)
        idx = self._agent_to_index[agent]
        if self._agent_points is not None:
            self._agent_points[idx, 0] = pos[0]
            self._agent_points[idx, 1] = pos[1]
        agent.pos = pos

    def remove_agent(self, agent: Agent) -> None:
        """Remove an agent from the simulation.

        Args:
            agent: The agent object to remove
        """
        if agent not in self._agent_to_index:
            raise Exception("Agent does not exist in the space")
        idx = self._agent_to_index[agent]
        del self._agent_to_index[agent]
        max_idx = max(self._index_to_agent.keys())
        # Delete the agent's position and decrement the index/agent mapping
        self._agent_points = np.delete(self._agent_points, idx, axis=0)
        for a, index in self._agent_to_index.items():
            if index > idx:
                self._agent_to_index[a] = index - 1
                self._index_to_agent[index - 1] = a
        # The largest index is now redundant
        del self._index_to_agent[max_idx]
        agent.pos = None

    def get_neighbors(
        self, pos: FloatCoordinate, radius: float, include_center: bool = True
    ) -> List[GridContent]:
        """Get all objects within a certain radius.

        Args:
            pos: (x,y) coordinate tuple to center the search at.
            radius: Get all the objects within this distance of the center.
            include_center: If True, include an object at the *exact* provided
                            coordinates. i.e. if you are searching for the
                            neighbors of a given agent, True will include that
                            agent in the results.
        """
        deltas = np.abs(self._agent_points - np.array(pos))
        if self.torus:
            deltas = np.minimum(deltas, self.size - deltas)
        dists = deltas[:, 0] ** 2 + deltas[:, 1] ** 2

        (idxs,) = np.where(dists <= radius ** 2)
        neighbors = [
            self._index_to_agent[x] for x in idxs if include_center or dists[x] > 0
        ]
        return neighbors

    def get_heading(
        self, pos_1: FloatCoordinate, pos_2: FloatCoordinate
    ) -> FloatCoordinate:
        """Get the heading angle between two points, accounting for toroidal space.

        Args:
            pos_1, pos_2: Coordinate tuples for both points.
        """
        one: NDArray[np.float64] = np.array(pos_1)
        two: NDArray[np.float64] = np.array(pos_2)
        if self.torus:
            with np.errstate(invalid='ignore'):
                # nan_to_num fixes zero size dimensions (e.g. flatland)
                one = np.nan_to_num((one - self.center) % self.size)
                two = np.nan_to_num((two - self.center) % self.size)
        heading: NDArray[np.float64] = two - one
        if isinstance(pos_1, tuple):
            return (heading[0], heading[1], heading[2])
        return heading

    def get_distance(self, pos_1: FloatCoordinate, pos_2: FloatCoordinate) -> float:
        """Get the distance between two point, accounting for toroidal space.

        Args:
            pos_1, pos_2: Coordinate tuples for both points.
        """
        x1, y1, z1 = pos_1
        x2, y2, z2 = pos_2

        dx = np.abs(x1 - x2)
        dy = np.abs(y1 - y2)
        dz = np.abs(z1 - z2)
        if self.torus:
            dx = min(dx, self.width - dx)
            dy = min(dy, self.height - dy)
            dz = min(dz, self.depth - dz)
        return float(np.sqrt(dx * dx + dy * dy + dz * dz))

    def torus_adj(self, pos: FloatCoordinate) -> FloatCoordinate:
        """Adjust coordinates to handle torus looping.

        If the coordinate is out-of-bounds and the space is toroidal, return
        the corresponding point within the space. If the space is not toroidal,
        raise an exception.

        Args:
            pos: Coordinate tuple to convert.
        """
        if not self.out_of_bounds(pos):
            return pos
        if not self.torus:
            raise Exception(f"Point {pos} out of bounds, and space non-toroidal.")
        x = self.p_min[0] + ((pos[0] - self.p_min[0]) % self.width)
        y = self.p_min[1] + ((pos[1] - self.p_min[1]) % self.height)
        z = (0 if self.depth == 0
             else self.p_min[2] + ((pos[2] - self.p_min[2]) % self.depth))
        if isinstance(pos, tuple):
            return (x, y, z)
        return np.array((x, y, z))

    def out_of_bounds(self, pos: FloatCoordinate) -> bool:
        """Check if a point is out of bounds."""
        # pylint: disable=too-many-return-statements
        x, y, z = pos
        # deals with zero-size dimensions
        if x < self.p_min[0] or x > self.p_max[0]:
            return True
        if self.width > 0 and x == self.p_max[0]:
            return True
        if y < self.p_min[1] or y > self.p_max[1]:
            return True
        if self.height > 0 and y == self.p_max[1]:
            return True
        if z < self.p_min[2] or z > self.p_max[2]:
            return True
        if self.depth > 0 and z == self.p_max[2]:
            return True
        return False

# Similar but simpler than above, no limit, no torus.
class LimitlessContinuous3dSpace:
    def __init__(self) -> None:
        self._agent_points: Optional[NDArray[np.float64]] = None
        self._index_to_agent: Dict[int, Agent] = {}
        self._agent_to_index: Dict[Agent, int] = {}

    def place_agent(self, agent: Agent, pos: FloatCoordinate) -> None:
        if self._agent_points is None:
            self._agent_points = np.array([pos])
        else:
            self._agent_points = np.append(self._agent_points, np.array([pos]), axis=0)
        self._index_to_agent[self._agent_points.shape[0] - 1] = agent
        self._agent_to_index[agent] = self._agent_points.shape[0] - 1
        agent.pos = pos

    def move_agent(self, agent: Agent, pos: FloatCoordinate) -> None:
        idx = self._agent_to_index[agent]
        if self._agent_points is not None:
            self._agent_points[idx, 0] = pos[0]
            self._agent_points[idx, 1] = pos[1]
        agent.pos = pos

    def remove_agent(self, agent: Agent) -> None:
        if agent not in self._agent_to_index:
            raise Exception("Agent does not exist in the space")
        idx = self._agent_to_index[agent]
        del self._agent_to_index[agent]
        max_idx = max(self._index_to_agent.keys())
        # Delete the agent's position and decrement the index/agent mapping
        self._agent_points = np.delete(self._agent_points, idx, axis=0)
        for a, index in self._agent_to_index.items():
            if index > idx:
                self._agent_to_index[a] = index - 1
                self._index_to_agent[index - 1] = a
        # The largest index is now redundant
        del self._index_to_agent[max_idx]
        agent.pos = None

    def get_neighbors(
        self, pos: FloatCoordinate, radius: float, include_center: bool = True
    ) -> List[GridContent]:
        deltas = np.abs(self._agent_points - np.array(pos))
        dists = deltas[:, 0] ** 2 + deltas[:, 1] ** 2

        (idxs,) = np.where(dists <= radius ** 2)
        neighbors = [
            self._index_to_agent[x] for x in idxs if include_center or dists[x] > 0
        ]
        return neighbors

    def get_heading(
        self, pos_1: FloatCoordinate, pos_2: FloatCoordinate
    ) -> FloatCoordinate:
        one: NDArray[np.float64] = np.array(pos_1)
        two: NDArray[np.float64] = np.array(pos_2)
        heading: NDArray[np.float64] = two - one
        if isinstance(pos_1, tuple):
            return (heading[0], heading[1], heading[2])
        return heading

    def get_distance(self, pos_1: FloatCoordinate, pos_2: FloatCoordinate) -> float:
        x1, y1, z1 = pos_1
        x2, y2, z2 = pos_2

        dx = np.abs(x1 - x2)
        dy = np.abs(y1 - y2)
        dz = np.abs(z1 - z2)
        return float(np.sqrt(dx * dx + dy * dy + dz * dz))
