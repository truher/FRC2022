from typing import Any, List
import matplotlib.pyplot as plt # type:ignore
import numpy as np
import pandas as pd # type:ignore

def plot_overlay2(bff: Any, series: str, lim: float, measure: str) -> None:
    # multiplot, range precision x gun precision
    urp = pd.unique(bff['rp'])
    ugp = pd.unique(bff['gp'])
    #fig, axs = plt.subplots(len(urp), len(ugp))
    fig, axs = plt.subplots(len(ugp))
    for s1 in range(len(urp)):
        for s2 in range(len(ugp)):
            rp = urp[s1]
            gp = ugp[s2]
            filtered = bff.loc[(bff['gp']==gp) & (bff['rp']==rp)]
            #axis = axs if len(urp) == 1 and len(ugp) == 1 else axs[s1,s2]
            axis = axs if len(urp) == 1 and len(ugp) == 1 else axs[s2]
            axis.scatter(filtered['r'],filtered[series], label=f"range precision {rp}")
            axis.set_xlim((0,9))
            axis.set_ylim((0,lim))
            axis.set_xlabel("actual range (m)")
            axis.set_ylabel(measure)
            axis.set_title(f"gun precision {gp}")
            axis.legend()
    plt.tight_layout(pad=0)
    plt.show()

def plot_overlay(bff: Any, series: str, lim: float, measure: str) -> None:
    # multiplot, range precision x gun precision
    urp = pd.unique(bff['rp'])
    ugp = pd.unique(bff['gp'])
    #fig, axs = plt.subplots(len(urp), len(ugp))
    fig, axs = plt.subplots(len(urp))
    for s1 in range(len(urp)):
        for s2 in range(len(ugp)):
            rp = urp[s1]
            gp = ugp[s2]
            filtered = bff.loc[(bff['gp']==gp) & (bff['rp']==rp)]
            #axis = axs if len(urp) == 1 and len(ugp) == 1 else axs[s1,s2]
            axis = axs if len(urp) == 1 and len(ugp) == 1 else axs[s1]
            axis.scatter(filtered['r'],filtered[series], label=f"gun precision {gp}")
            axis.set_xlim((0,9))
            axis.set_ylim((0,lim))
            axis.set_xlabel("actual range (m)")
            axis.set_ylabel(measure)
            axis.set_title(f"range precision {rp}")
            axis.legend()
    plt.tight_layout(pad=0)
    plt.show()

def plot_big_overlay(bff: Any, series: str, lim: float, measure: str) -> None:
    # multiplot, range precision x gun precision
    urp = pd.unique(bff['rp'])
    ugp = pd.unique(bff['gp'])
    fig, axs = plt.subplots()
    for s1 in range(len(urp)):
        for s2 in range(len(ugp)):
            rp = urp[s1]
            gp = ugp[s2]
            filtered = bff.loc[(bff['gp']==gp) & (bff['rp']==rp)]
            axis = axs
            axis.scatter(filtered['r'],filtered[series], label=f"rp {rp} gp {gp}")
            axis.set_xlim((0,9))
            axis.set_ylim((0,lim))
            axis.set_xlabel("actual range (m)")
            axis.set_ylabel(measure)
            axis.set_title(measure)
            axis.legend()
    plt.tight_layout(pad=0)
    plt.show()

def plot_results(bff: Any, series: str, lim: float, measure: str) -> None:
    # multiplot, range precision x gun precision
    urp = pd.unique(bff['rp'])
    ugp = pd.unique(bff['gp'])
    fig, axs = plt.subplots(len(urp), len(ugp))
    for s1 in range(len(urp)):
        for s2 in range(len(ugp)):
            rp = urp[s1]
            gp = ugp[s2]
            filtered = bff.loc[(bff['gp']==gp) & (bff['rp']==rp)]
            axis = axs if len(urp) == 1 and len(ugp) == 1 else axs[s1,s2]
            axis.scatter(filtered['r'],filtered[series], label=f"r{rp} g{gp}")
            axis.set_xlim((0,9))
            axis.set_ylim((0,lim))
            #axis.set_xlabel("actual range (m)")
            #axis.set_ylabel(measure)
            axis.set_title(f"range precision {rp} gun precision {gp}")
    plt.tight_layout(pad=0)
    #print(f"{measure} by actual range (m) range precision {rp} gun precision {gp}")
    print(f"{measure} by actual range (m)")
    plt.show()

def run_all() -> None:
    df = pd.read_csv('new_results.csv')
    print(df)
    plot_results(df, 'h', 1.1, "best p(hit)")
    #plot_big_overlay(df, 'h', 1.1, "best p(hit)")
    #plot_overlay(df, 'h', 1.1, "best p(hit)")
    #plot_overlay2(df, 'h', 1.1, "best p(hit)")
    plot_results(df, 'v', 15, "best velocity (m/s)")
    #plot_big_overlay(df, 'v', 15, "best velocity (m/s)")
    #plot_overlay(df, 'v', 15, "best velocity (m/s)")
    #plot_overlay2(df, 'v', 15, "best velocity (m/s)")
    plot_results(df, 'l', 90, "best elevation (degrees)")
    #plot_big_overlay(df, 'l', 90, "best elevation (degrees)")
    #plot_overlay(df, 'l', 90, "best elevation (degrees)")
    #plot_overlay2(df, 'l', 90, "best elevation (degrees)")

if __name__ == '__main__':
    run_all()
