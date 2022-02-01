#import multiprocessing
from typing import Any, List, Tuple
import matplotlib.pyplot as plt # type:ignore
import numpy as np
import pandas as pd # type:ignore
import constants
import trajectory

# verify the model extracted from the sweep data

# parameter bounds
TARGET_MIN_RANGE_M: float = 1
TARGET_MAX_RANGE_M: float = 16.46/2 # field length/2

def target(target_range_m: float) -> Any:
    return pd.DataFrame({
        'x':[target_range_m - constants.TARGET_RADIUS_M,
             target_range_m + constants.TARGET_RADIUS_M],
        'y':[constants.TARGET_HEIGHT_M, constants.TARGET_HEIGHT_M]}
    )

def run_all() -> None:
    bf: List = []
    range_range: List = list(np.arange(TARGET_MIN_RANGE_M, TARGET_MAX_RANGE_M, 0.1))
    for r in range_range:
        bf.append(hit_the_target(r))
    bff = pd.DataFrame(bf)
    print(bff.to_csv())

def plot_trajectory(target_range_m, df, summary) -> None:
    df2 = target(target_range_m)
    plt.axis('scaled') # x and y same scale
    plt.scatter(df['x'],df['y'], label="trajectory")
    plt.plot(df2['x'],df2['y'], label="target")
    plt.xlim((0,10))
    plt.ylim((0,10))
    plt.title(summary)
    plt.show()

def firing_solution(target_range_m) -> Tuple[float, float]:
    """returns velocity (m/s), elevation (degrees)"""
    # from the spreadsheet
    v_a: float = 0.87
    v_b: float = 4.61
    v_c: float = 0.98
    e_a: float = 84.2
    e_b: float = -0.305
    model_velocity: float = v_a * target_range_m + v_b + v_c/target_range_m
    model_elevation: float = e_a *pow(target_range_m, e_b)
    return model_velocity, model_elevation

def hit_the_target(target_range_m):
    muzzle_velocity_m_s, gun_elevation_degrees = firing_solution(target_range_m)
    outcome, energy_J, df = trajectory.run(target_range_m, muzzle_velocity_m_s,
                                           gun_elevation_degrees, True)
    summary: str = (
        f"range {target_range_m:.2f} "
        f"velocity {muzzle_velocity_m_s:.2f} "
        f"elevation {gun_elevation_degrees:.2f} "
        f"arrival energy {energy_J:.2f} "
        f"outcome {outcome}")
    plot_trajectory(target_range_m, df, summary)

if __name__ == '__main__':
    run_all()
