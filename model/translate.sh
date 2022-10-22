#!/bin/bash -v

###################################################################
# Translate with a trained model.

set -eu

MODELDIR=$MEMO_MODEL
DATADIR=$MEMO_DATA
vocab=joint.model.spm
model=model.npz

$MARIAN_BINARIES/marian-decoder \
  -m $MODELDIR/$model \
  -v $MODELDIR/$vocab $MODELDIR/$vocab \
  -d $(seq 0 7) \
  --mini-batch 32 --maxi-batch 1000 --maxi-batch-sort src \
  --max-length 1000 --max-length-crop \
  -w 24000 \
  "$@"
