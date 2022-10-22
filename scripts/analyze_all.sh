dir=$1
file=noisy
for i in {1..5}
do
    echo "Perturbation for ${i} with mode=suffix"
    bash $MEMO_HOME/scripts/analyze.sh $MEMO_DATA/$file.$dir.raw.$i.tsv suffix
    echo "Perturbation for ${i} with mode=prefix"
    bash $MEMO_HOME/scripts/analyze.sh $MEMO_DATA/$file.$dir.raw.$i.tsv prefix
    echo "Perturbation for ${i} with mode=start"
    bash $MEMO_HOME/scripts/analyze.sh $MEMO_DATA/$file.$dir.raw.$i.tsv start
done
