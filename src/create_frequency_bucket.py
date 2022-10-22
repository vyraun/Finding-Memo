import sys
from collections import Counter
from pdb import set_trace as bp
import random

data1 = []
f = open(sys.argv[1], "r")
for line in f:
    data1.append(line.strip())
f.close()

data2 = []
f = open(sys.argv[2], "r")
for line in f:
    data2.append(line.strip())
f.close()

data = []
for s, t in zip(data1, data2):
    data.append(s + "\t" + t)

threshold = int(sys.argv[3])

# Shuffle the data before creating a bucket
random.shuffle(data)
freq = Counter(data)
bucket = freq.most_common()[::-1]

max_num=100000
index=0
values = []
for x, c in bucket:
    if c == threshold: # and len( x.split("\t")[0].split() ) >= 4: # why this 4?
        values.append(x)
        index += 1
    if index >= max_num:
        break

# This makes no sense, what was I doing here?
max_sample = min(len(values), max_num)
sampled_values = random.sample(values, max_sample)
for x in sampled_values:
    print(x)
