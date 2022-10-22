import sys, os
import numpy as np

x = np.loadtxt(sys.argv[1])
# Here is the Threshold
# 0.75 is the one I am using in the paper
below_one = [ i for i, t in enumerate(x) if t <= 0.75 ]

pairs = []
f = open(sys.argv[2], "r")
for line in f:
    pairs.append(line.strip())

below_one_pairs = [ pairs[i] for i in below_one ] 
for sp, i in zip(below_one_pairs, below_one):
    print(sp + "\t" + str(x[i]))

import matplotlib.pyplot as plt
import numpy as np

np.random.seed(42)
#print(np.mean(x), np.std(x))

plt.hist(x, range=[0.0, 1.0], density=False)  # density=False would make counts
plt.ylabel('Counts')
plt.xlabel('Normalized Position of Hallucination Trigger in Source')
plt.title('Mean = {}, Std = {}'.format(np.mean(x), np.std(x)))
#plt.legend('Mean = {}'.format(np.mean(x)))
#plt.legend('Std = {}'.format(np.std(x)))
#Diagnostics, not important, make this nice later
plt.savefig("{}.png".format( sys.argv[1] ))
