import sys

f1 = open(sys.argv[1], "r")
f2 = open(sys.argv[2], "r")
f3 = open(sys.argv[3], "r")

truth = []
out = []
source = []

for l1, l2, l3 in zip(f1, f2, f3):
    truth.append(l1.strip())
    out.append(l2.strip())
    source.append(l3.strip())

index = 1
for t, o, s in zip(truth, out, source):
    if t == o:
        print(t + "\t" + str(index) + "\t" + s)
    index += 1