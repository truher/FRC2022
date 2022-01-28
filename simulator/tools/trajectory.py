from typing import Any, Tuple
import random
import numpy as np
import pandas as pd # type:ignore
import constants

# simulate some ballistic paths to make a range-velocity-elevation guide

# simulate one trajectory
def run(target_range_m: float, muzzle_velocity_m_s: float,
        gun_elevation_degrees: float, return_trajectory: bool) -> Tuple[str, float, Any]:
    # pylint: disable=chained-comparison
    dt_s: float = constants.BALL_RADIUS_M / (2 * muzzle_velocity_m_s) # keep steps fine enough
    v0x_m_s: float = muzzle_velocity_m_s * np.cos(np.pi * gun_elevation_degrees / 180)
    v0y_m_s: float = muzzle_velocity_m_s * np.sin(np.pi * gun_elevation_degrees / 180)
    df = [] # list of dicts
    vx_m_s: float = v0x_m_s
    vy_m_s: float = v0y_m_s
    x_m: float = 0
    y_m: float	= constants.FIRING_HEIGHT_M
    v_m_s: float = np.sqrt(vx_m_s * vx_m_s + vy_m_s * vy_m_s)
    Fd: float = constants.DRAG_CONSTANT * v_m_s * v_m_s
    Ad: float = Fd / constants.MASS_KG
    angle_rad: float = np.arctan2(vy_m_s, vx_m_s)
    Adx: float = Ad * np.cos(angle_rad)
    Ady: float = Ad * np.sin(angle_rad)
    for t_s in np.arange(0, 10, dt_s):
        vx_m_s += - Adx * dt_s
        vy_m_s += - Ady * dt_s + constants.G_M_S_S * dt_s
        dx_m: float = vx_m_s * dt_s
        dy_m: float = vy_m_s * dt_s
        # move less than one ball radius per step, to make the hit function work.
        # and to reduce inaccuracy in the drag calculation
        if dx_m > constants.BALL_RADIUS_M:
            raise Exception(f"at t={t_s} dx={dx_m} too big")
        if dy_m > constants.BALL_RADIUS_M:
            raise Exception(f"at t={t_s} dy={dy_m} too big")
        x_m += dx_m
        y_m += dy_m
        v_m_s = np.sqrt(vx_m_s * vx_m_s + vy_m_s * vy_m_s)
        energy_J: float = constants.MASS_KG * v_m_s * v_m_s / 2
        Fd = constants.DRAG_CONSTANT * v_m_s * v_m_s
        Ad = Fd / constants.MASS_KG
        angle_rad = np.arctan2(vy_m_s, vx_m_s)
        Adx = Ad * np.cos(angle_rad)
        Ady = Ad * np.sin(angle_rad)

        if return_trajectory:
            df.append({'x':x_m, 'y':y_m})

        if vy_m_s < 0 and y_m + constants.BALL_RADIUS_M < constants.TARGET_HEIGHT_M:
            # below the target, heading down
            return "miss", energy_J, df

        if y_m < 0:
            # stop if you hit the ground
            return "miss", energy_J, df

        if (x_m + constants.BALL_RADIUS_M > target_range_m - constants.TARGET_RADIUS_M and
            x_m - constants.BALL_RADIUS_M < target_range_m + constants.TARGET_RADIUS_M and
            y_m > constants.TARGET_HEIGHT_M - constants.BALL_RADIUS_M and
            y_m < constants.TARGET_HEIGHT_M + constants.BALL_RADIUS_M and vy_m_s >= 0):
            # can't hit the target from below
            return "miss", energy_J, df

        if ( x_m - constants.BALL_RADIUS_M > target_range_m - constants.TARGET_RADIUS_M and
            x_m + constants.BALL_RADIUS_M < target_range_m + constants.TARGET_RADIUS_M and
            y_m > constants.TARGET_HEIGHT_M and
            y_m < constants.TARGET_HEIGHT_M + constants.BALL_RADIUS_M and vy_m_s < 0):
            # intersect the target disc from the top
            if is_captured(energy_J):
                print("captured")
                return "hit", energy_J, df
            print("bounced out")
            return "miss", energy_J, df

    return "miss", 0, df

BUCKET_WALL_HEIGHT_M = 0.8 # guessing from the game manual
BUCKET_POTENTIAL_WELL_J = constants.MASS_KG * constants.G_M_S_S * BUCKET_WALL_HEIGHT_M # about 2 joules
ELASTICITY = 0.5 # pretty soft
def is_captured(energy_J: float) -> bool:
    while True: # bounce forever
        energy_J = energy_J * ELASTICITY # bounce
        angle_rad = random.uniform(0, np.pi)
        if angle_rad < np.pi/4 or angle_rad > 3*np.pi/4:
            continue # hit the wall
        vertical_component_J = energy_J / np.sin(angle_rad)
        if vertical_component_J < - BUCKET_POTENTIAL_WELL_J:
            return True
        return False
