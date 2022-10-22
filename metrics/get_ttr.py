import sys
from typing import Dict
from numpy import NaN

f = open(sys.argv[1], "r")
lines = []

for line in f:
    lines.append(line.strip())

def get_vocabulary(sentence_array):
    """Compute vocabulary
        :param sentence_array: a list of sentences
        :returns: a list of tokens
    """
    data_vocabulary = {}
    total = 0

    for sentence in sentence_array:
        for token in sentence.strip().split():
            if token not in data_vocabulary:
                data_vocabulary[token] = 1
            else:
                data_vocabulary[token] += 1
            total += 1

    return total, data_vocabulary

def compute(predictions) -> Dict:
    total, vocabulary = get_vocabulary(predictions)
    if total == 0:
        score = NaN
    else:
        score = len(vocabulary)/total
    return round(score, 5)

print("TTR score = {}".format(compute(lines)))
