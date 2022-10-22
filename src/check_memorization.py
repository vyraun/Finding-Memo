import sys

# Given translations and references
# Check if translation == reference

f = open(sys.argv[1], "r")
translations = []
for line in f:
    translations.append(line.strip())
f.close()

sources, references = [], []
f = open(sys.argv[2], "r")
for line in f:
    tokens = line.strip().split("\t")
    sources.append(tokens[0])
    references.append(tokens[1])
f.close()

memorized = [  x for x, y in zip(translations, references) if x == y ]
print( "Total Sentence Pairs = {}, Total Memorized = {}".format( len(translations), len(memorized) ) )
