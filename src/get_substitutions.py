import sys
from substitutions import get_bert_substitutions as get_mlm_substitutions
from pdb import set_trace as bp

f = open(sys.argv[1], "r")
perturb_mode = sys.argv[2]
perturb_mode = perturb_mode.strip()

sources = []
positions = []
references = []

for line in f:
    tokens = line.strip().split("\t")
    sources.append(tokens[1].strip())
    positions.append(tokens[3].strip())
    references.append(tokens[2].strip())

# Now call substututions
# Prefix Perturbation vs Suffix Perturbation
for s, p, r in zip(sources, positions, references):

    n = len( s.split() )
    p = float(p)
    pos = int( n * p )

    # I am ignoring the exact position which triggers the memorization
    # Since that will artifically inflate the number for suffix

    if perturb_mode == "prefix":
        positions = list(range(1, pos))
    elif perturb_mode == "start":
        positions = [1]
    else:
        positions = list(range(pos +1, n + 1))

    for position in positions:
        new_sents = get_mlm_substitutions(s, position)
        for x in new_sents:
            print(x + "\t" + r)

# Now, I need to get the translations of these new sentences
# Check if they are exactly the same or not
# I only need to translate them, then check if the references are the same or not
