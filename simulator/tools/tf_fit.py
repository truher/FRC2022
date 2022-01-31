import numpy as np
import matplotlib.pyplot as plt
import tensorflow as tf
import math

x1_data = np.linspace(1, 10, num=19)
x2_data = [0.1, 0.3, 0.5]
x_data = np.column_stack(
    (
        np.tile(x1_data, len(x2_data)),
        np.tile(x2_data, len(x1_data))
    )
)
x_data = np.tile(x_data,(10,1))
#y_data = np.asarray([ 0.1*i[0]*i[1]*np.cos(i[0]) + 0.1*np.random.normal() for i in x_data])
y_data = np.asarray([ i[0] + i[1] + np.random.normal() for i in x_data])

model = tf.keras.Sequential([
    tf.keras.layers.Dense(units = 2, activation = 'linear', input_shape=[2]),
    tf.keras.layers.Dense(units = 64, activation = 'relu'),
    tf.keras.layers.Dense(units = 64, activation = 'relu'),
    tf.keras.layers.Dense(units = 1, activation = 'linear'),
])
model.compile(loss='mse', optimizer="adam")

model.summary()
model.fit(x_data, y_data, epochs=1000, verbose=1)
y_predicted = model.predict(x_data)

plt.scatter(x_data[:,0], y_data)
plt.plot(x_data[:,0], y_predicted, 'r+')
plt.grid()
plt.show()
plt.scatter(x_data[:,1], y_data)
plt.plot(x_data[:,1], y_predicted, 'r+')
plt.grid()
plt.show()
