import sys

out = open(sys.argv[1], "r")
ref = open(sys.argv[2], "r")

outputs = []
refs = []

for line in out:
    outputs.append(line.strip())

for line in ref:
    refs.append(line.strip())

removed = []
for line in outputs:
    if line.startswith("%"):
        removed.append(line[2:].strip())
    else:
        removed.append(line.strip())

cnt  = 0
rem  = 0
for o, r, rm in zip(outputs, refs, removed):
    if o == r:
        cnt += 1
    if r == rm:
        rem += 1

print("{}/{} remained the same, {}/{} are same after symbol removal".format(cnt, len(outputs), rem, len(outputs)))
