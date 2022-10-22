import sys
from pdb import set_trace as bp

cjkt = False

f = open(sys.argv[1], "r")
source, translation = [], []
final = False
temp_src = []
temp_trg = []
for line in f:
    tokens = line.split("\t")
    if tokens[0].strip() == "Prefix":
        temp_src.append(tokens[1].strip())
        temp_trg.append(tokens[2].strip())
    else:
        temp_src.append(tokens[1].strip())
        temp_trg.append(tokens[2].strip())
        # Append and Reset
        source.append(temp_src)
        translation.append(temp_trg)
        temp_src, temp_trg = [], []

# Now the stat I want is
# Take the final translation
# print(source)

prefix_vals = []
for s, t in zip(source, translation):
    memorized = t[-1]
    final = s[-1]
    for x, y in zip(s, t):
        if y.strip() == memorized.strip():
            if cjkt:
                x = list(x)
                final = list(final)
            else:
                x = x.split()
                final = final.split()
            prefix_vals.append(len(x)/len(final))
            break

for x in prefix_vals:
    print(x)
