output=$1

# The input is the noisy.tsv file
# bash augment.sh noisy.1-5.tsv

symbol='!' # * @ # $ %

cut -f2 $output > $MEMO_DATA/noisy_src.txt
cut -f3 $output > $MEMO_DATA/output_orig.txt

python $MEMO_HOME/src/augment_source.py $MEMO_DATA/noisy_src.txt $symbol > $MEMO_DATA/noisy_aug_src.txt
bash $MEMO_HOME/model/translate.sh -b1 -i $MEMO_DATA/noisy_aug_src.txt -o $MEMO_DATA/noisy_aug_out.txt
paste $MEMO_DATA/noisy_src.txt $MEMO_DATA/noisy_aug_src.txt $MEMO_DATA/noisy_aug_out.txt $MEMO_DATA/output_orig.txt > $MEMO_DATA/noisy_aug.tsv

python $MEMO_HOME/src/mem_changed.py $MEMO_DATA/noisy_aug.tsv $symbol > $MEMO_DATA/mem_ft.tsv
tail -n 1 $MEMO_DATA/mem_ft.tsv
sed -i '$d' $MEMO_DATA/mem_ft.tsv

# Prepare the FT data
cut -f1 $MEMO_DATA/mem_ft.tsv > $MEMO_DATA/mem_src.txt
cut -f2 $MEMO_DATA/mem_ft.tsv > $MEMO_DATA/mem_trg.txt
cut -f3 $MEMO_DATA/mem_ft.tsv > $MEMO_DATA/mem_ref.txt

cut -f1,2 $MEMO_DATA/mem_ft.tsv > $MEMO_DATA/mem_ft.txt
cut -f1,3 $MEMO_DATA/mem_ft.tsv > $MEMO_DATA/old_ft.txt
