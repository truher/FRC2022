import numpy as np
import pandas as pd # type:ignore
import matplotlib.pyplot as plt # type:ignore
import tensorflow as tf # type:ignore

def plot_all(df, measure, prediction, lim):
    x2_values = pd.unique(df['gp'])
    x3_values = pd.unique(df['rp'])
    _, axs = plt.subplots(len(x2_values),len(x3_values))
    for s2, x2 in enumerate(x2_values):
        for s3, x3 in enumerate(x3_values):
            filtered = df.loc[(df['gp']==x2) & (df['rp']==x3)].sort_values('r')
            axs[s2,s3].scatter(filtered['r'],  filtered[measure])
            axs[s2,s3].plot(filtered['r'],  filtered[prediction], 'r+-')
            axs[s2,s3].set_title(f"gp {x2} rp {x3}")
            axs[s2,s3].set_ylim((0,lim))
    plt.tight_layout(pad=0)
    plt.show()

def make_data():
    x1_data = np.linspace(1, 10, num=19)
    x2_data = [0.1, 0.3, 0.5]
    x3_data = [0.1, 0.3, 0.5]
    x_data = np.column_stack(
        (
            np.tile(np.repeat(x1_data, len(x2_data)*len(x3_data)), 1),
            np.tile(np.repeat(x2_data,              len(x3_data)), len(x1_data)),
            np.tile(np.repeat(x3_data,                         1), len(x1_data)*len(x2_data))
        )
    )
    x_data = np.tile(x_data,(10,1)) # lots of examples
    print(x_data)
    y_data = np.asarray([np.cos(i[0])
                         + 10/i[1]
                         - 5*i[2]
                         + 0.1*np.random.normal() for i in x_data])

    return pd.DataFrame(np.column_stack((x_data, y_data)), columns=('x1','x2','x3','y'))

def make_model():
    xin = tf.keras.Input(shape=(3), name='xin')
    x1 = tf.keras.layers.Dense(units=64, activation='relu', name='x1')(xin)
    x2 = tf.keras.layers.Dense(units=64, activation='relu', name='x2')(x1)
    x3a = tf.keras.layers.Dense(units=64, activation='relu', name='x3a')(x2)
    x3b = tf.keras.layers.Dense(units=64, activation='relu', name='x3b')(x2)
    x3c = tf.keras.layers.Dense(units=64, activation='relu', name='x3c')(x2)
    # sigmoid discourages p(hit)>1
    hout = tf.keras.layers.Dense(units=1, activation='sigmoid', name='hout')(x3a)
    vout = tf.keras.layers.Dense(units=1, activation='linear', name='vout')(x3b)
    lout = tf.keras.layers.Dense(units=1, activation='linear', name='lout')(x3c)
    model = tf.keras.Model(
        inputs=[xin],
        outputs=[hout, vout, lout]
    )
    tf.keras.utils.plot_model(model, "model.png", show_shapes=True)
    model.compile(
        optimizer="adam", # works way better than sgd
        loss={
            'hout':'mape',
            'vout':'mape',
            'lout':'mape'
        },
        loss_weights={
            'hout':4.0,
            'vout':1.0,
            'lout':1.0
        }
    )
    model.summary()
    return model

def run():
    model = make_model()
    #df = make_data()
    df = pd.read_csv('new_results.csv')
    model.fit(
        {
            'xin':df[['r','gp','rp']].to_numpy()
        },
        {
              'hout':df['h'].to_numpy(),
              'vout':df['v'].to_numpy(),
              'lout':df['l'].to_numpy()
        },
        epochs=2000,
        verbose=1
    )
    model.save('fit_model')
    predictions = model.predict(df[['r','gp','rp']].to_numpy())
    reshaped = np.reshape(np.transpose(predictions), (-1, 3))
    pdf = pd.DataFrame(reshaped, columns=['hp','vp','lp'])
    df = pd.concat((df, pdf), axis=1)
    print(df)
    plot_all(df, 'h', 'hp', 1.1)
    plot_all(df, 'v', 'vp', 14)
    plot_all(df, 'l', 'lp', 90)

if __name__ == '__main__':
    run()
