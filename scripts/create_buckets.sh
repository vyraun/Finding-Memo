data_dir=$1
train_src=$2
train_trg=$3

echo "Bucketization Starting..."
for i in {1..5}
do
    python $MEMO_HOME/src/create_frequency_bucket.py $data_dir/$train_src $data_dir/$train_trg $i > $MEMO_DATA/$data_dir.raw.$i
    echo "Bucket created for ${i}"
done
