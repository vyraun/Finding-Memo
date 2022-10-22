import sys

f = open(sys.argv[1], "r")
source = []
for line in f:
    source.append(line.strip())

symbol = sys.argv[2].strip()

def augment(s):
    return "{} ".format(symbol) + s

for x in source:
    print(augment(x))
