from typing import Any, List
import matplotlib.pyplot as plt # type:ignore
import numpy as np
import pandas as pd # type:ignore
import constants
import trajectory

# sanity check trajectories group at a time

MUZZLE_VELOCITY_MIN_M_S: float = 5
MUZZLE_VELOCITY_MAX_M_S: float = 14
GUN_ELEVATION_MIN_DEGREES: float = 35
GUN_ELEVATION_MAX_DEGREES: float = 85

def target(target_range_m: float) -> Any:
    return pd.DataFrame({
        'x':[target_range_m - constants.TARGET_RADIUS_M,
             target_range_m + constants.TARGET_RADIUS_M],
        'y':[constants.TARGET_HEIGHT_M, constants.TARGET_HEIGHT_M]}
    )

def run_all() -> None:
    bf: List[dict] = []
    range_range: List = list(np.arange(constants.TARGET_MIN_RANGE_M, constants.TARGET_MAX_RANGE_M, 1))
    for r in range_range:
        bf.extend(sweep_with_precision(r))
    print("the results")
    print(bf)
    bff = pd.DataFrame(bf)
    bff.to_csv('new_results.csv')
    print(bff.to_csv())

def sweep_with_precision(target_range) -> List[dict]:
    """
        range_precision jitters the range estimate.
            it doesn't matter that much, the target is pretty big.  the optimal shot gets a little
            higher as precision gets worse.
        gun_precision jitters both velocity and elevation.
            it makes a huge difference.  at 1%, 90% close shots are possible and long shots are around
            60%. at 5%, the best shot is 3m at 75% or so, and long shots decline to 25%.  at 10%
            the best shot is 3m at 45%, long shots under 20%.  i'm sure this is just about the spread
            being bigger than the target diameter.
        overall hit rate is strongly dependent on range: under 4 meters, >90% is possible.  over
            4m, 60% is possible.  i'm sure this is all about bouncing, so calibrating the bounce
            model seems important.
    """
    bf: List[dict] = []
    for range_precision in [0.02, 0.05, 0.1]:
        for gun_precision in [0.01, 0.05, 0.1]:
            print(f"sweep range {target_range} "
                  f"gun_precision {gun_precision} "
                  f"range_precision {range_precision}")
            one_sweep: dict = sweep_gun(target_range, gun_precision, range_precision)
            bf.append(one_sweep)
    print("about to return this")
    print(bf)
    return bf

def sweep_gun(target_range_m:float, gun_precision:float, range_precision:float) -> dict:
    """
    gun_precision: std dev of angle and velocity.  1% = best possible, 10% = unusable
    range_precision std dev of range measurement.  2% = best possible, 10% = unusable
    """
    min_energy_J: float = 1000.0
    best_v: float = 0.0
    best_el: float = 0.0
    best_p_hit:float = 0.0
    for muzzle_velocity_m_s in np.arange(
        MUZZLE_VELOCITY_MIN_M_S, MUZZLE_VELOCITY_MAX_M_S, 0.5):
        for gun_elevation_degrees in np.arange(GUN_ELEVATION_MIN_DEGREES,
            GUN_ELEVATION_MAX_DEGREES, 1):
            tries = 100
            hits = 0
            hit_trajectories = []
            miss_trajectories = []
            for _ in range(tries):
                actual_muzzle_velocity_m_s = muzzle_velocity_m_s * np.random.normal(1.0, gun_precision)
                actual_gun_elevation_degrees = gun_elevation_degrees * np.random.normal(1.0, gun_precision)
                actual_target_range_m = target_range_m * np.random.normal(1.0, range_precision)
                outcome, energy_J, df = trajectory.run( # df is list of dicts
                    actual_target_range_m,
                    actual_muzzle_velocity_m_s,
                    actual_gun_elevation_degrees,
                    True # return the trajectories
                )
                if outcome == "hit":
                    hit_trajectories += df
                    hits += 1
                else:
                    miss_trajectories += df
            if hits == 0:
                continue
            p_hit = hits/tries
            summary: str = (
                f"range {target_range_m} "
                f"velocity {muzzle_velocity_m_s} "
                f"elevation {gun_elevation_degrees} "
                f"arrival energy {energy_J:.2f} "
                f"p(hit) {p_hit}")
            if p_hit > best_p_hit:

                print(f"{summary} = new best")
                min_energy_J = energy_J
                best_v = muzzle_velocity_m_s
                best_el = gun_elevation_degrees
                best_p_hit = p_hit

            # show the trajectory
            hf = pd.DataFrame(hit_trajectories)
            mf = pd.DataFrame(miss_trajectories)
            df2 = target(target_range_m)
            plt.axis('scaled')
            if len(mf):
                plt.plot(mf['x'], mf['y'], label='miss', marker='.', markersize='1',
                    linestyle='none', color='red')
            if len(hf):
                plt.plot(hf['x'], hf['y'], label='hit', marker='.',  markersize='1',
                    linestyle='none', color='green')
            plt.plot(df2['x'],df2['y'], label="target", marker='o', markersize=5,
                linewidth=5, color='black')
            plt.xlim((0,9))
            plt.ylim((0,5))
            plt.title(summary)
            plt.show()
    return {
        'r': target_range_m,
        'gp': gun_precision,
        'rp': range_precision,
        'e': min_energy_J,
        'h': best_p_hit,
        'v': best_v,
        'l': best_el
    }

if __name__ == '__main__':
    run_all()
