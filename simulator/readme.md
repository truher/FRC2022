# FRC

The general idea is a brute-force monte carlo over a set of regionals:

* do this many times
 * make a bunch of teams with random capabilities
 * 100 round-robins for ranking points
 * selection with the top 8, picking randomly
 * playoff elimination
 * the reward is "member of winning alliance"

## How to Run

Launch the model:
```
    $ python3 run.py
```


## Notes about Mesa

* agent location is a property of the space not the agent; the agent asks the space where it is. ... not true, location is in *both* places
* time is measured in "steps", a few scheduler options: in-order (like mason), random-order, simultaneous (i.e. all agents perceive the same t-1 state and commit together), and multi-stage, with a list of "step" function names.  simultaneous seems like the most "physical" though if the step is small enough it probably doesn't matter.
* there's a "batch runner" 
* there's a discrete space and a continuous space.  continuous seems more "physical"
* the visualizer FPS thing is the delay for js settimeout; i think i just want to get rid of that, but the fps bounds are in the framework.  how to override it?  in the install in ~/src.  ha ha also setting it to zero tickles a bug i think that means "full speed" .. apparently that's not a bug https://www.w3.org/TR/2011/WD-html5-20110525/timers.html
* boids is the only example of continuous space, so adapt that.
* batch\_run example is broken, fixed it, whatever.
* the visualizer drives the steps, which is funny.  close the browser, and it stops.
* the visualizer dimensions are confusing.  bootstrap is confusing.

## TODO

* make pylint and that type checking thing work... version hell
* fix the width/height swap in the examples
