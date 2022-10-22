# This script does the following things:
# 1. Based on Reference, extract which sentences are exactly replicated
# 2. Get the prefixes of those samples
# 3. Translate the Prefixes
# 4. Observe how quickly the prefixes generate the memorized translations
# This does not distinguish between the nature of the samples: clean or noisy

#input=$1
#ref=$2

# Construct Frequency Buckets
# paste $input $ref > data_pairs.tsv
# python create_frequency_bucket.py data_pairs.tsv 5 > new_data_pairs.tsv

new_data_pairs=$1
identifier=$2

cut -f1 $new_data_pairs > $MEMO_DATA/new_input
cut -f2 $new_data_pairs > $MEMO_DATA/new_ref

# Get the Translations
bash $MEMO_HOME/model/translate.sh -b1 -i $MEMO_DATA/new_input -o $MEMO_DATA/new_output

# Extract Memorized Sentences
python  $MEMO_HOME/src/extract_memorized.py $MEMO_DATA/new_ref $MEMO_DATA/new_output $MEMO_DATA/new_input > $MEMO_DATA/memorized.$identifier
cut -f2 $MEMO_DATA/memorized.$identifier > $MEMO_DATA/memorized.indices.$identifier
cut -f1 $MEMO_DATA/memorized.$identifier > $MEMO_DATA/memorized.out.$identifier
cut -f3 $MEMO_DATA/memorized.$identifier > $MEMO_DATA/memorized.src.$identifier

echo "Memorized Extracted"

# Generate and Translate Prefixes
python $MEMO_HOME/src/generate_prefixes.py $MEMO_DATA/memorized.src.$identifier > $MEMO_DATA/prefixes
# Clean this up later
cp  $MEMO_DATA/prefixes $MEMO_DATA/prefixes.1k
cat $MEMO_DATA/prefixes.1k | cut -f2 > $MEMO_DATA/prefixes.1k.src
#bash test.sh prefixes.1k.src prefixes.1k.src exp2-99-2.9e+01.pt
bash $MEMO_HOME/model/translate.sh -b1 -i $MEMO_DATA/prefixes.1k.src -o $MEMO_DATA/translations
paste $MEMO_DATA/prefixes.1k $MEMO_DATA/translations > $MEMO_DATA/translations.$identifier.tsv
grep "^Final" $MEMO_DATA/translations.$identifier.tsv > $MEMO_DATA/finals.$identifier.tsv

echo "Extracted Prefixes"

# Parse the Generated Data
python $MEMO_HOME/src/parse_memorized.py $MEMO_DATA/translations.$identifier.tsv > $MEMO_DATA/scores.$identifier.txt
paste  $MEMO_DATA/finals.$identifier.tsv $MEMO_DATA/scores.$identifier.txt > $MEMO_DATA/output.$identifier.tsv
python $MEMO_HOME/src/compute_dist.py $MEMO_DATA/scores.$identifier.txt $MEMO_DATA/finals.$identifier.tsv > $MEMO_DATA/noisy.$identifier.tsv

#python neighborhood.py noisy.tsv > perturbed_mem_src
#cut -f3 noisy.tsv > perturbed_mem_ref
#bash translate.sh -b1 -i perturbed_mem_src -o perturbed_mem_out
#python compute_neighborhood_stats.py perturbed_mem_out perturbed_mem_ref
# analyze the perturbed translation in relation to the

echo "Analysis Done"
