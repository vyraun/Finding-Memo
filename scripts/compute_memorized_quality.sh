dir=$1
file=noisy
for i in {1..5}
do
    echo "Quality Metrics (COMET-QE and TTR) for ${i}"
    cut -f2 $MEMO_DATA/$file.$dir.raw.$i.tsv > $MEMO_DATA/memorized.src
    cut -f3 $MEMO_DATA/$file.$dir.raw.$i.tsv > $MEMO_DATA/memorized.trg
    bash   $MEMO_HOME/metrics/comet_qa.sh $MEMO_DATA/memorized.src $MEMO_DATA/memorized.trg
    python $MEMO_HOME/metrics/get_ttr.py  $MEMO_DATA/memorized.src
done
