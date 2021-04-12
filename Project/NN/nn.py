import tensorflow as tf

import numpy as np

def myActivation(x):
    return tf.keras.backend.sigmoid(x*4)

def getModel():
    model = tf.keras.Sequential([
        tf.keras.layers.Dense(2, activation=tf.keras.activations.sigmoid, input_dim=2),
        tf.keras.layers.Dense(1)
        ])
    model.compile(optimizer=tf.keras.optimizers.SGD(learning_rate=0.6), loss=tf.keras.losses.mean_squared_error, metrics='accuracy')

    return model

def getTrainedModel():
    model = tf.keras.Sequential([
        tf.keras.layers.Dense(2, activation=tf.keras.activations.sigmoid, input_dim=2),
        tf.keras.layers.Dense(1)
        ])
    model.compile(optimizer=tf.keras.optimizers.SGD(learning_rate=0.6), loss=tf.keras.losses.mean_squared_error, metrics='accuracy')
    model = getModel()
    model.load_weights('traning/xorModel')
    return model

def getTrainingData():
    n = 2000
    X = np.random.randint(0, 2, (n, 2))
    y = np.array([(X[i][0]^X[i][1])&1 for i in range(n)])

    return (X, y)

def sigmoid(x):                                        
    return 1 / (1 + np.exp(-x))

def feed(x, model):
    w = model.get_weights()
    x1 = sigmoid(x@w[0] + w[1])
    x2 = sigmoid(x1@np.squeeze(w[2]) + w[3])
    print('w')

if __name__ == "__main__":
    model = getModel()
    X, y = getTrainingData()
    model.fit(X,y, epochs=40)
    print(model.predict(np.array([[1,1],[0,0],[0,1],[1,0]])) > 0.5)
    model.save_weights('traning/xorModel')

    model2 = getModel()
    model2.load_weights('traning/xorModel')
    print(model2.predict(np.array([[1,1]])))
    #extractor = tf.keras.Model(inputs=model2.inputs,
    #                    outputs=[layer.output for layer in model2.layers])
    #features = extractor(np.array([[1,1]]))
    #feed(np.array([1,1]), model2)
    #print('2')