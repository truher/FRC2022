import numpy as np

# problem constants
FIRING_HEIGHT_M: float = 1
TARGET_HEIGHT_M: float = 2.64
BALL_RADIUS_M: float = 0.12
TARGET_RADIUS_M: float = 0.5 # this is a 2-d analysis; ignore the edges

# constant constants
G_M_S_S: float = -9.8
AIR_DENSITY_KG_M3: float = 1.225
MASS_KG: float = 0.270
DRAG_CONSTANT: float = np.pi * AIR_DENSITY_KG_M3 * BALL_RADIUS_M * BALL_RADIUS_M / 4

# parameter bounds
TARGET_MIN_RANGE_M: float = 1
TARGET_MAX_RANGE_M: float = 16.46/2 # field length/2
