import multiprocessing
from typing import Any, List
import matplotlib.pyplot as plt # type:ignore
import numpy as np
import pandas as pd # type:ignore
import constants
import trajectory

# simulate some ballistic paths to make a range-velocity-elevation guide

SINGLE: bool = False
#SINGLE: bool = True
MUZZLE_VELOCITY_MIN_M_S: float = 5
MUZZLE_VELOCITY_MAX_M_S: float = 20
GUN_ELEVATION_MIN_DEGREES: float = 35
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
    range_range: List = list(np.arange(constants.TARGET_MIN_RANGE_M, constants.TARGET_MAX_RANGE_M, 1))
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

GUN_PRECISION = 0.01 # std dev of angle and velocity
def sweep_gun(target_range_m) -> dict:
    min_energy_J: float = 1000
    best_v: float = 0
    best_el: float = 0
    best_p_hit = 0
    for muzzle_velocity_m_s in np.arange(
        MUZZLE_VELOCITY_MIN_M_S, MUZZLE_VELOCITY_MAX_M_S, 1):
        print(f"range {target_range_m} velocity {muzzle_velocity_m_s}")
        for gun_elevation_degrees in np.arange(GUN_ELEVATION_MIN_DEGREES,
            GUN_ELEVATION_MAX_DEGREES, 1):
            print(f"range {target_range_m} "
                  f"velocity {muzzle_velocity_m_s} "
                  f"elevation {gun_elevation_degrees}")
            tries = 100
            hits = 0
            all_tries = [] # the trajectories
            for i in range(tries):
                actual_muzzle_velocity_m_s = muzzle_velocity_m_s * np.random.normal(1.0, GUN_PRECISION)
                actual_gun_elevation_degrees = gun_elevation_degrees * np.random.normal(1.0, GUN_PRECISION)
                outcome, energy_J, df = trajectory.run( # df is list of dicts
                    target_range_m,
                    actual_muzzle_velocity_m_s,
                    actual_gun_elevation_degrees,
                    True # don't return each trajectory
                )
                all_tries += df
                if outcome == "hit":
                    hits += 1
            #print(f"hits {hits}")
            if hits == 0:
                #print("no hits")
                continue
            p_hit = hits/tries
            summary: str = (
                f"range {target_range_m} "
                f"velocity {muzzle_velocity_m_s} "
                f"elevation {gun_elevation_degrees} "
                f"arrival energy {energy_J:.2f} "
                f"p(hit) {p_hit}")
            print(summary)
            if p_hit > best_p_hit:
                print("new best")
                min_energy_J = energy_J
                best_v = muzzle_velocity_m_s
                best_el = gun_elevation_degrees
                best_p_hit = p_hit
            if SINGLE:
                af = pd.DataFrame(all_tries)
                df2 = target(target_range_m)
                plt.scatter(af['x'],af['y'], label="trajectories", s=2)
                plt.plot(df2['x'],df2['y'], label="target")
                plt.title(summary)
                plt.show()
## FIXME
    return {'r': target_range_m, 'e': best_p_hit, 'v': best_v, 'l': best_el}

if __name__ == '__main__':
    # main is required to avoid mp deadlock
    multiprocessing.freeze_support()
    multiprocessing.set_start_method('forkserver')
    run_all()
