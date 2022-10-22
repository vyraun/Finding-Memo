model_dir=tfmr
data_dir=wmt20

mkdir -p ${model_dir}

$MARIAN_BINARIES/marian \
    --model $model_dir/model.npz --type transformer \
    --train-sets $data_dir/train.en $data_dir/train.de \
    --max-length 256 \
    --vocabs $data_dir/joint.model.spm $data_dir/joint.model.spm \
    --mini-batch-fit true --mini-batch-fit-step 5 --workspace 32000 --maxi-batch 1000 --mini-batch 1000 --mini-batch-warmup 4000 \
    --early-stopping 10 \
    --valid-freq 5000 --save-freq 5000 --disp-freq 10 \
    --valid-metrics cross-entropy perplexity bleu chrf \
    --valid-sets $data_dir/valid.en $data_dir/valid.de \
    --valid-mini-batch 64 \
    --beam-size 5 \
    --log $model_dir/train.log --valid-log $model_dir/valid.log \
    --enc-depth 6 --dec-depth 6 \
    --transformer-heads 16 \
    --dim-emb 1024 \
    --transformer-ffn-activation relu \
    --transformer-dim-ffn 4096 \
    --transformer-postprocess-emb d \
    --transformer-postprocess dan \
    --transformer-dropout 0.1 --transformer-dropout-attention 0.1 --transformer-dropout-ffn 0.1 --label-smoothing 0.1 \
    --learn-rate 0.0002 --optimizer adam --cost-type ce-sum --lr-warmup 8000 --lr-decay-inv-sqrt 8000 --lr-report \
    --optimizer-params 0.9 0.98 1e-09 --clip-norm 0 \
    --after-batches 300000 \
    --tied-embeddings \
    --devices 0 1 2 3 4 5 6 7 --sync-sgd --seed 1111 \
    --exponential-smoothing 1e-4
