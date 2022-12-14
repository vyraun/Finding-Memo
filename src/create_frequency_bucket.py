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
    if c == threshold:
        values.append(x)
        index += 1
    if index >= max_num:
        break

max_sample = min(len(values), max_num)
sampled_values = random.sample(values, max_sample)
for x in sampled_values:
    print(x)
