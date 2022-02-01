import multiprocessing
from typing import Any, List, Optional
import numpy as np
import pandas as pd # type:ignore
import constants
import trajectory

# simulate some ballistic paths to make a range-velocity-elevation guide

MUZZLE_VELOCITY_MIN_M_S: float = 5
MUZZLE_VELOCITY_MAX_M_S: float = 14
GUN_ELEVATION_MIN_DEGREES: float = 35
GUN_ELEVATION_MAX_DEGREES: float = 85

def run_multi() -> List[dict]:
    # pylint: disable=consider-using-with
    # multi-processing
    range_range: List = list(np.arange(constants.TARGET_MIN_RANGE_M, constants.TARGET_MAX_RANGE_M, 0.5))
    p: Any = multiprocessing.Pool(processes=6, maxtasksperchild=100)
    return p.imap_unordered(sweep_with_precision, range_range)

def run_all() -> None:
    bf: List[dict] = []
    multi_bf: List[List[dict]] = run_multi()
    bf.extend([i for s in multi_bf for i in s])
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
    for range_precision in [0.02, 0.04, 0.06]:
        for gun_precision in [0.01, 0.03, 0.05]:
            for i in range(3): # a few points for training
                print(f"try {i} sweep range {target_range} gun_precision {gun_precision} "
                      f"range_precision {range_precision}")
                one_sweep: Optional[dict] = sweep_gun(target_range, gun_precision, range_precision)
                if one_sweep is not None:
                    bf.append(one_sweep)
    return bf

def sweep_gun(target_range_m:float, gun_precision:float, range_precision:float) -> dict:
    """
    gun_precision: std dev of angle and velocity.  1% = best possible, 10% = unusable
    range_precision std dev of range measurement.  2% = best possible, 10% = unusable
    """
    min_energy_J: float = 1000
    best_v: float = 0
    best_el: float = 0
    best_p_hit = 0
    skip: int = 0 # step faster in zero-hit regions
    for muzzle_velocity_m_s in np.arange(
        MUZZLE_VELOCITY_MIN_M_S, MUZZLE_VELOCITY_MAX_M_S, 0.5):
        #print(f"range {target_range_m} velocity {muzzle_velocity_m_s}")
        for gun_elevation_degrees in np.arange(GUN_ELEVATION_MIN_DEGREES,
            GUN_ELEVATION_MAX_DEGREES, 1):
            if skip > 0:
                skip -= 1
                continue
            #print(f"range {target_range_m} "
            #      f"velocity {muzzle_velocity_m_s} "
            #      f"elevation {gun_elevation_degrees}")
            tries = 100
            hits = 0
            for i in range(tries):
                actual_muzzle_velocity_m_s = muzzle_velocity_m_s * np.random.normal(1.0, gun_precision)
                actual_gun_elevation_degrees = gun_elevation_degrees * np.random.normal(1.0, gun_precision)
                actual_target_range_m = target_range_m * np.random.normal(1.0, range_precision)
                outcome, energy_J, _ = trajectory.run(
                    actual_target_range_m,
                    actual_muzzle_velocity_m_s,
                    actual_gun_elevation_degrees,
                    False # don't return each trajectory
                )
                if outcome == "hit":
                    hits += 1
            if hits == 0:
                print("skip zero")
                skip = 5
                continue
            p_hit = hits/tries
            print(f"range {target_range_m} velocity {muzzle_velocity_m_s} "
                  f"elevation {gun_elevation_degrees} arrival energy {energy_J:.2f} "
                  f"p(hit) {p_hit}")
            if p_hit > best_p_hit:
                print("new best")
                min_energy_J = energy_J
                best_v = muzzle_velocity_m_s
                best_el = gun_elevation_degrees
                best_p_hit = p_hit
            if best_p_hit - p_hit > 0.2: # go faster on the way down
                print("skip down")
                skip = 5
    if min_energy_J == 1000:
        return None
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
    # main is required to avoid mp deadlock
    multiprocessing.freeze_support()
    multiprocessing.set_start_method('forkserver')
    run_all()
