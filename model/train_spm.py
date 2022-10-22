import sentencepiece as spm
import sys

input=sys.argv[1]
vocab_size=int(sys.argv[2])

options  = "--bos_id=-1 --unk_id=1 --byte_fallback=true --character_coverage=0.9995 --eos_id=0 --input_sentence_size=10000000"
options += " --shuffle_input_sentence=true --model_type=unigram"

spm.SentencePieceTrainer.train('--input={} --model_prefix=joint --vocab_size={} {}'.format(input, vocab_size, options))
