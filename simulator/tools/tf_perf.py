import timeit
import numpy as np
import tensorflow as tf # type:ignore

# performance testing the tf model.
# five-layer (incl input), 64 wide, three head, 35ms.
# simplifying the model made it worse but not faster.

model = tf.keras.models.load_model('fit_model')

def run():
    rp = 0.02
    gp = 0.01
    for r in np.linspace(1,8,100):
        pred = model.predict([[r,gp,rp]])
        print(f"range {r:.2f}: p {float(pred[0][0]):.2f} "
              f"v {float(pred[1][0]):.2f} l {float(pred[2][0]):.2f}")

print(timeit.timeit('run()',
      number=10,
      globals=globals()))
