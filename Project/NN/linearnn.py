import tensorflow as tf

import numpy as np

INPUT_SIZE = 3

def getModel():
    model = tf.keras.Sequential([
        tf.keras.layers.Input(INPUT_SIZE),
        tf.keras.layers.Dense(1,activation=tf.keras.activations.sigmoid)
        ])
    model.compile(optimizer=tf.keras.optimizers.SGD(learning_rate=0.6), loss=tf.keras.losses.mean_squared_error, metrics='accuracy')

    return model

def getSinTrainedModel():
    model = tf.keras.Sequential([
        tf.keras.layers.Input(INPUT_SIZE),
        tf.keras.layers.Dense(1)
        ])
    model.compile(optimizer=tf.keras.optimizers.SGD(learning_rate=0.3), loss=tf.keras.losses.mean_squared_error, metrics='accuracy')
    model = getModel()
    model.load_weights('traning/linearModel')
    return model

def getTrainingData():
    n = 2000
    X = np.random.randint(0, 2, (n, INPUT_SIZE))
    y = np.array([((X[i][0]|X[i][1])&X[i][2])&1 for i in range(n)])

    return (X, y)

if __name__ == "__main__":
    model = getModel()
    X, y = getTrainingData()
    model.fit(X,y, epochs=20)
    print(model.predict(np.array([[1,1,0],[1,0,0],[0,1,1],[1,1,1]])) > 0.5)
    model.save_weights('traning/linearModel')