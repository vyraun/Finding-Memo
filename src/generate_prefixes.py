import sys

f1 = open(sys.argv[1], "r")
lines = []
for line in f1:
    lines.append(line.strip())

def generate_prefixes(input):
    tokens = input.split()
    return [" ".join(tokens[0:i]).strip() for i in range(1, len(tokens)-1)]

def generate_prefixes_truncated(input):
    tokens = input.split()
    start = len(tokens)//3
    return [" ".join(tokens[0:i]).strip() for i in range(start + 1, len(tokens)-1)]


prefixes = []
for line in lines:
    line_prefixes = generate_prefixes(line)
    line_prefixes = [ "Prefix \t" + x for x in line_prefixes ]
    prefixes += line_prefixes
    prefixes += [ "Final \t" + line ]

for p in prefixes:
    print(p)
