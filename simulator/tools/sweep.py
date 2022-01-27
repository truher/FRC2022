import multiprocessing
from typing import Any, List
import matplotlib.pyplot as plt # type:ignore
import numpy as np
import pandas as pd # type:ignore
import constants
import trajectory

# simulate some ballistic paths to make a range-velocity-elevation guide

SINGLE: bool = False
MUZZLE_VELOCITY_MIN_M_S: float = 1
MUZZLE_VELOCITY_MAX_M_S: float = 20
GUN_ELEVATION_MIN_DEGREES: float = 5
GUN_ELEVATION_MAX_DEGREES: float = 85

def target(target_range_m: float) -> Any:
    return pd.DataFrame({
        'x':[target_range_m - constants.TARGET_RADIUS_M,
             target_range_m + constants.TARGET_RADIUS_M],
        'y':[constants.TARGET_HEIGHT_M, constants.TARGET_HEIGHT_M]}
    )

def plot_results(bff: Any) -> None:
    fig, ax1 = plt.subplots()
    ax2=ax1.twinx()
    ax1.scatter(bff['r'], bff['e'], label="energy J", color="red")
    ax1.scatter(bff['r'], bff['v'], label="velocity m/s", color="blue")
    ax2.scatter(bff['r'], bff['l'], label="elevation degrees", color="green")
    ax1.legend()
    ax2.legend()
    plt.title('lowest energy for range')
    fig.tight_layout()
    plt.show()

def run_single() -> List:
    # single-thread for profiling
    bf: List = []
    range_range: List = list(np.arange(constants.TARGET_MIN_RANGE_M, constants.TARGET_MAX_RANGE_M, 2))
    for r in range_range:
        bf.append(sweep_gun(r))
    return bf

def run_multi() -> List:
    # pylint: disable=consider-using-with
    # multi-processing
    range_range: List = list(np.arange(constants.TARGET_MIN_RANGE_M, constants.TARGET_MAX_RANGE_M, 0.1))
    p: Any = multiprocessing.Pool(processes=6,
                                  maxtasksperchild=100)
    return p.imap_unordered(sweep_gun, range_range)

def run_all() -> None:
    bf: List
    if SINGLE:
        bf = run_single()
    else:
        bf = run_multi()
    bff = pd.DataFrame(bf)
    print(bff.to_csv())
    plot_results(bff)

def plot_trajectory(target_range_m, df, summary) -> None:
    df2 = target(target_range_m)
    plt.scatter(df['x'],df['y'], label="trajectory")
    plt.plot(df2['x'],df2['y'], label="target")
    plt.title(summary)
    plt.show()

def sweep_gun(target_range_m) -> dict:
    min_energy_J: float = 1000
    best_v: float = 0
    best_el: float = 0
    for muzzle_velocity_m_s in np.arange(
        MUZZLE_VELOCITY_MIN_M_S, MUZZLE_VELOCITY_MAX_M_S, 0.25):
        print(f"range {target_range_m} velocity {muzzle_velocity_m_s}")
        for gun_elevation_degrees in np.arange(GUN_ELEVATION_MIN_DEGREES,
            GUN_ELEVATION_MAX_DEGREES, 0.25):
            outcome, energy_J, df = trajectory.run(
                target_range_m,
                muzzle_velocity_m_s,
                gun_elevation_degrees,
                False # don't return each trajectory
            )
            summary: str = (
                f"range {target_range_m} "
                f"velocity {muzzle_velocity_m_s} "
                f"elevation {gun_elevation_degrees} "
                f"arrival energy {energy_J:.2f} "
                f"outcome {outcome}")
            if outcome != "hit":
                continue
            print(summary)
            if energy_J < min_energy_J:
                print("new best")
                min_energy_J = energy_J
                best_v = muzzle_velocity_m_s
                best_el = gun_elevation_degrees
            if SINGLE: # don't need to plot each trajectory
                plot_trajectory(target_range_m, df, summary)
    return {'r': target_range_m, 'e': min_energy_J, 'v': best_v, 'l': best_el}

if __name__ == '__main__':
    # main is required to avoid mp deadlock
    multiprocessing.freeze_support()
    multiprocessing.set_start_method('forkserver')
    run_all()
