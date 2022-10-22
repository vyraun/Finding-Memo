# Set these 4 variables
# The data directory should have the training source and target files
# The model directory should have the spm and model.npz files
data_dir=wmt20
model_dir=tfmr
training_src=train.en
training_trg=train.de

# Set some env variables
export MEMO_HOME=$(pwd)
export MEMO_DATA=$(pwd)/$data_dir
export MEMO_MODEL=$(pwd)/$model_dir
export MARIAN_BINARIES=/mnt/_default/marian_setup/binaries

# Run the scripts
bash $MEMO_HOME/scripts/create_buckets.sh $data_dir $training_src $training_trg
bash $MEMO_HOME/scripts/extract_all.sh $data_dir
bash $MEMO_HOME/scripts/compute_memorized_quality.sh $data_dir
bash $MEMO_HOME/scripts/analyze_all.sh $data_dir
