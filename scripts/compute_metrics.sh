file=$1

# Get Distribution of COMET Scores for the Memorized Samples
cut -f1 $file > $MEMO_DATA/all.src
cut -f2 $file > $MEMO_DATA/all.trg
bash $MEMO_HOME/metrics/comet_qa.sh $MEMO_DATA/all.src $MEMO_DATA/all.trg
python $MEMO_HOME/metrics/get_ttr.py $MEMO_DATA/all.src
