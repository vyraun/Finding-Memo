file=$1.raw
# File + index becomes the identifier
echo "Extraction Starting for ${file} Buckets"

for i in {1..5}
do
    # Pass the file path with its identifier -- redundant, clean up later
    bash $MEMO_HOME/scripts/extract_memorized.sh $MEMO_DATA/$file.$i $file.$i
    echo "Extraction Done for Frequency Bucket ${i}"
done

echo "Printing Memorized Samples for All 1-5"
for i in {1..5}
do
    echo "Results for Repetitions = ${i}"
    wc -l $MEMO_DATA/$file.$i
    wc -l $MEMO_DATA/noisy.$file.$i.tsv
done

echo "Computing Quality"
cat $MEMO_DATA/noisy.$file.*.tsv > $MEMO_DATA/temp.all
cut -f2,3 $MEMO_DATA/temp.all > $MEMO_DATA/temp.main
cut -f1 $MEMO_DATA/temp.main > $MEMO_DATA/temp.src
cut -f2 $MEMO_DATA/temp.main > $MEMO_DATA/temp.trg
bash $MEMO_HOME/metrics/comet_qa.sh $MEMO_DATA/temp.src $MEMO_DATA/temp.trg
