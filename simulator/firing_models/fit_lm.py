# use lmfit to extract some parameters from the simulated data, old-school.
#
# note:
# * i have no model for p(hit).  bleah
# * i'm also not using the precision values, which seems wrong.

from typing import Any
import pandas as pd # type:ignore
import matplotlib.pyplot as plt # type:ignore
import numpy as np
from lmfit import Model # type:ignore

def plot_results(bff: Any, obs: str, pred: str, lim: float, measure: str) -> None:
    # multiplot, range precision x gun precision
    urp = pd.unique(bff['rp'])
    ugp = pd.unique(bff['gp'])
    _, axs = plt.subplots(len(urp), len(ugp))
    for s1 in range(len(urp)):
        for s2 in range(len(ugp)):
            rp = urp[s1]
            gp = ugp[s2]
            filtered = bff.loc[(bff['gp']==gp) & (bff['rp']==rp)]
            axis = axs if len(urp) == 1 and len(ugp) == 1 else axs[s1,s2]
            axis.scatter(filtered['r'],filtered[obs], label=f"r{rp} g{gp}")
            axis.plot(filtered['r'],filtered[pred], color="red")
            axis.set_xlim((0,9))
            axis.set_ylim((0,lim))
            axis.set_xlabel("actual range (m)")
            axis.set_ylabel(measure)
            axis.set_title(f"range precision {rp} gun precision {gp}")
    plt.tight_layout(pad=0)
    plt.show()

def f_velocity(r, gp, rp, a_v=1, b_v=5, c_v=1, a_gp=100, b_gp=0, a_rp=100, b_rp=0):
    #return (a_v*r + b_v + c_v/r) * (a_gp * gp + b_gp) * (a_rp * rp + b_rp) # multiplicative errors?
    return a_v * r + b_v + c_v / r

def f_elevation(r, gp, rp, a_e=100, b_e=-1, a_gp=100, b_gp=0, a_rp=100, b_rp=0):
    #return a_e*pow(r,b_e) * (a_gp * gp + b_gp) * (a_rp * rp + b_rp) # multiplicative errors?
    return a_e * pow(r, b_e)

def fake_data():
    r = []
    rp = []
    gp = []
    velocity=[]
    elevation=[]
    for r_i in np.arange(1.0, 9.0, 1.0):
        for rp_i in [0.01, 0.05, 0.1]:
            for gp_i in [0.01, 0.05, 0.1]:
                r.append(r_i)
                rp.append(rp_i)
                gp.append(gp_i)
                velocity.append(f_velocity(r_i, gp_i, rp_i, 0.8, 4.6, 0.9) * np.random.normal(1.0, 0.1))
                elevation.append(f_elevation(r_i, gp_i, rp_i, 84, -0.3) * np.random.normal(1.0, 0.1))
    return pd.DataFrame({ 'r': r, 'gp': gp, 'rp': rp, 'v': velocity, 'l': elevation})

#df = fake_data()
df = pd.read_csv('new_results.csv')

# two independent models
velocity_model = Model(f_velocity, independent_vars=['r','gp','rp'])
elevation_model = Model(f_elevation, independent_vars=['r','gp','rp'])

velocity_fit = velocity_model.fit(df['v'], r = df['r'], gp = df['gp'], rp = df['rp'])
elevation_fit = elevation_model.fit(df['l'], r = df['r'], gp = df['gp'], rp = df['rp'])

print(velocity_fit.fit_report())
print(elevation_fit.fit_report())
for key in velocity_fit.params:
    print(f"{key} = {velocity_fit.params[key].value} +/- {velocity_fit.params[key].stderr}")
for key in elevation_fit.params:
    print(f"{key} = {elevation_fit.params[key].value} +/- {elevation_fit.params[key].stderr}")


df['pred_v'] = [
    f_velocity(r_i, gp_i, rp_i, velocity_fit.params['a_v'].value, velocity_fit.params['b_v'].value, velocity_fit.params['c_v'].value)
    for r_i, gp_i, rp_i in zip(df['r'], df['gp'], df['rp'])
]
df['pred_l'] = [
    f_elevation(r_i, gp_i, rp_i, elevation_fit.params['a_e'].value, elevation_fit.params['b_e'].value)
    for r_i, gp_i, rp_i in zip(df['r'], df['gp'], df['rp'])
]

plot_results(df, 'v', 'pred_v', 15, "velocity")
plot_results(df, 'l', 'pred_l', 90, "velocity")
