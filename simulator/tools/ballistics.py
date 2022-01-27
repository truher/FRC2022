import matplotlib.pyplot as plt
import multiprocessing
import numpy as np
import pandas as pd

# simulate some ballistic paths to make a range-velocity-elevation guide

# problem constants
FIRING_HEIGHT_M = 1
TARGET_HEIGHT_M = 2.64
BALL_RADIUS_M = 0.12
TARGET_RADIUS_M = 0.5 # this is a 2-d analysis; ignore the edges
DT_S = 0.005

# constant constants
G_M_S_S = -9.8
AIR_DENSITY_KG_M3 = 1.225
MASS_KG = 0.270
DIAMETER_M = 0.240
DRAG_CONSTANT = np.pi * AIR_DENSITY_KG_M3 * DIAMETER_M * DIAMETER_M / 16

MUZZLE_VELOCITY_MIN_M_S = 5
MUZZLE_VELOCITY_MAX_M_S = 25
#muzzle_velocity_m_s = 13.9
GUN_ELEVATION_MIN_DEGREES = 10
GUN_ELEVATION_MAX_DEGREES = 90
#gun_elevation_degrees = 32

# parameter bounds
TARGET_MIN_RANGE_M = 1
TARGET_MAX_RANGE_M = 16.46/2 # field length/2

def target(target_range_m):
    return pd.DataFrame({
        'x':[target_range_m-TARGET_RADIUS_M, target_range_m+TARGET_RADIUS_M],
        'y':[TARGET_HEIGHT_M, TARGET_HEIGHT_M]}
    )

def plot_results(bff):
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

def run_all():
    bf = []
    range_range = np.arange(TARGET_MIN_RANGE_M, TARGET_MAX_RANGE_M, 0.25)
    p = multiprocessing.Pool(processes=6, maxtasksperchild=100)
    bf = p.imap_unordered(sweep_gun, range_range)
    bff = pd.DataFrame(bf)
    print(bff.to_csv())
    plot_results(bff)

def plot_trajectory(target_range_m, df, summary):
    df2 = target(target_range_m)
    plt.scatter(df['x'],df['y'], label="trajectory")
    plt.plot(df2['x'],df2['y'], label="target")
    plt.title(summary)
    plt.show()

def sweep_gun(target_range_m):
    min_energy_J = 1000
    best_v = 0
    best_el = 0
    for muzzle_velocity_m_s in np.arange(
        MUZZLE_VELOCITY_MIN_M_S, MUZZLE_VELOCITY_MAX_M_S, 0.5):
        for gun_elevation_degrees in np.arange(GUN_ELEVATION_MIN_DEGREES,
            GUN_ELEVATION_MAX_DEGREES, 0.5):
            outcome, energy_J, df = run(
                target_range_m,
                muzzle_velocity_m_s,
                gun_elevation_degrees
            )
            summary = (
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
            if False:
                plot_trajectory(target_range_m, df, summary)
    return {'r': target_range_m, 'e': min_energy_J, 'v': best_v, 'l': best_el}

def run(target_range_m: float, muzzle_velocity_m_s: float,
    gun_elevation_degrees: float): # one trajectory
    v0x_m_s = muzzle_velocity_m_s * np.cos(np.pi * gun_elevation_degrees / 180)
    v0y_m_s = muzzle_velocity_m_s * np.sin(np.pi * gun_elevation_degrees / 180)
    outcome = "miss"
    df = pd.DataFrame()
    vx_m_s = v0x_m_s
    vy_m_s = v0y_m_s
    x_m = 0
    y_m	= FIRING_HEIGHT_M
    v_m_s = np.sqrt(vx_m_s * vx_m_s + vy_m_s * vy_m_s)
    #momentum = v_m_s * MASS_KG
    #energy_J = MASS_KG * v_m_s * v_m_s / 2
    Fd = DRAG_CONSTANT * v_m_s * v_m_s
    Ad = Fd / MASS_KG
    angle_rad = np.arctan2(vy_m_s, vx_m_s)
    Adx = Ad * np.cos(angle_rad)
    Ady = Ad * np.sin(angle_rad)
    for t_s in np.arange(0, 10, DT_S):
        vx_m_s += - Adx * DT_S
        vy_m_s += - Ady * DT_S + G_M_S_S * DT_S 
        dx_m = vx_m_s * DT_S
        dy_m = vy_m_s * DT_S
        # move less than one ball radius per step, to make the hit function work.
        # and to reduce inaccuracy in the drag calculation
        if dx_m > BALL_RADIUS_M: 
            raise Exception(f"at t={t_s} dx={dx_m} too big")
        if dy_m > BALL_RADIUS_M:
            raise Exception(f"at t={t_s} dy={dy_m} too big")
        x_m += dx_m
        y_m += dy_m
        v_m_s = np.sqrt(vx_m_s * vx_m_s + vy_m_s * vy_m_s)
        #momentum = v_m_s * MASS_KG
        energy_J = MASS_KG * v_m_s * v_m_s / 2
        Fd = DRAG_CONSTANT * v_m_s * v_m_s
        Ad = Fd / MASS_KG
        angle_rad = np.arctan2(vy_m_s, vx_m_s)
        Adx = Ad * np.cos(angle_rad)
        Ady = Ad * np.sin(angle_rad)

        df = df.append({'x':x_m, 'y':y_m}, ignore_index=True)

        # a hit == ball in the target plane, moving downward.
        #if vy_m_s >= 0:
            #row['outcome'] = 'miss'
            #break # can't hit the target from below
        if vy_m_s < 0 and y_m + BALL_RADIUS_M < TARGET_HEIGHT_M:
            return "miss", energy_J, df # below the target, heading down
        if y_m < 0:
            # stop if you hit the ground
            return "miss", energy_J, df

        if (x_m + BALL_RADIUS_M > target_range_m - TARGET_RADIUS_M and 
            x_m - BALL_RADIUS_M < target_range_m + TARGET_RADIUS_M and
            y_m > TARGET_HEIGHT_M - BALL_RADIUS_M and
            y_m < TARGET_HEIGHT_M + BALL_RADIUS_M and vy_m_s >= 0):
                # can't hit the target from below
                return "miss", energy_J, df

        if ( x_m - BALL_RADIUS_M > target_range_m - TARGET_RADIUS_M and 
            x_m + BALL_RADIUS_M < target_range_m + TARGET_RADIUS_M and
            y_m > TARGET_HEIGHT_M and
            y_m < TARGET_HEIGHT_M + BALL_RADIUS_M and vy_m_s < 0):
            # intersect the target disc from the top
            outcome = "hit" 
            return "hit", energy_J, df
    return "miss", df

if __name__ == '__main__':
    # main is required to avoid mp deadlock
    multiprocessing.freeze_support()
    multiprocessing.set_start_method('forkserver')
    run_all()
