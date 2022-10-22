src=$1
trg=$2

comet-score -s $src -t $trg --model wmt20-comet-qe-da --quiet
