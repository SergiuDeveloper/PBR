import numpy as np
import itertools

from nn import getTrainedModel
from linearnn import getSinTrainedModel

model = getSinTrainedModel()
shape = (3, 1)
w = [np.array(model.get_weights()[layer]) for layer in range(2)]
# w detine weight-urile si bias-urile modelului
# Pe pozitia 0 weights, pe pozitia 1 biases

WEIGHT_VALUE = 0
LAST_NEURON = 1
NEURON = 2
OUTPUT_LAYER = 0
INPUT_LAYER = 1

def getPositiveWeightsFor(neuron):
    """
    Returns all positive weighs linking input to the neuron in output specified

    Attribute: 
    neruon : int 
        Index of the neuron in the last layer

    weights are returned like this touple: 
    (weight_value, index_of_input_neuron, index_of_output_neuron)
    """
    positiveWeights = []
    for inputNeur in range(shape[INPUT_LAYER]):
        if w[0][inputNeur][neuron] > 0:
            positiveWeights.append((w[0][inputNeur][neuron], inputNeur, neuron))
    return positiveWeights

def getNegativeWeightsFor(neuron):
    negativeWeights = []
    for inputNeur in range(shape[INPUT_LAYER]):
        if w[0][inputNeur][neuron] < 0:
            negativeWeights.append((w[0][inputNeur][neuron], inputNeur, neuron))
    return negativeWeights


def getPositiveSubsetsFor(neuron):
    """
    Returns all combinations of positive weight to the neuron.
    """
    positiveWeights = getPositiveWeightsFor(neuron)
    allSubsets = []
    for r in range(1, len(positiveWeights) + 1):
        combinationsObject = itertools.combinations(positiveWeights, r)
        combinationsList = list(combinationsObject)
        allSubsets += combinationsList
    return allSubsets


def getNegativeSubsetsFor(neuron):
    """
    Returns all combinations of negative weight to the neuron.
    """
    negativeWeights = getNegativeWeightsFor(neuron)
    allSubsets = []
    for r in range(1, len(negativeWeights) + 1):
        combinationsObject = itertools.combinations(negativeWeights, r)
        combinationsList = list(combinationsObject)
        allSubsets += combinationsList
    return allSubsets


if __name__ == "__main__":

    for neuron in range(shape[OUTPUT_LAYER]):
        bias = w[1][neuron]

        def subsetsWithSumBiggerThanBias(subset):
            return True if sum([weight[WEIGHT_VALUE] for weight in subset]) + bias > 0 else False

        positiveSubsets = getPositiveSubsetsFor(neuron)
        positiveSubsets = list(filter(subsetsWithSumBiggerThanBias, positiveSubsets))
        for positiveSubset in positiveSubsets:
            negativeSubsets = getNegativeSubsetsFor(neuron)

            def smallEnoughNegativeSubsets(negativeSubset):
                negativeWeightsSum = sum([weight[WEIGHT_VALUE] for weight in negativeSubset])
                positiveWeightsSum = sum([weight[WEIGHT_VALUE] for weight in positiveSubset])
                return True if positiveWeightsSum + bias - negativeWeightsSum < 0 else False

            negativeSubsets = list(filter(smallEnoughNegativeSubsets, negativeSubsets))
            ## To Do: get only the minimum ones.
            for negativSubset in negativeSubsets:
                inputNeurons = "".join(["{}".format(w[LAST_NEURON]) for w in negativSubset])
                print("If Inputs:", inputNeurons, "then ", "Z", negativSubset[0][NEURON])
            
            inputNeurons = "".join(["{} and ".format(w[LAST_NEURON]) for w in positiveSubset])
            print("If Inputs:", inputNeurons, "then ", "Output:", positiveSubset[0][NEURON])
    
    print("Done")
