noisy_file=$1
perturb_mode=$2

# Get Distribution of COMET Scores for the Memorized Samples
cut -f2 $noisy_file > $MEMO_DATA/memorized.src
cut -f3 $noisy_file > $MEMO_DATA/memorized.trg

python $MEMO_HOME/src/get_substitutions.py $noisy_file $perturb_mode > $MEMO_DATA/perturbed_src.tsv
cut -f1 $MEMO_DATA/perturbed_src.tsv > $MEMO_DATA/perturbed_src
bash $MEMO_HOME/model/translate.sh -b1 -i $MEMO_DATA/perturbed_src -o $MEMO_DATA/perturbed_translations --quiet
paste $MEMO_DATA/perturbed_src.tsv $MEMO_DATA/perturbed_translations > $MEMO_DATA/perturbed.tsv
python $MEMO_HOME/src/check_memorization.py $MEMO_DATA/perturbed_translations $MEMO_DATA/perturbed_src.tsv

