# Finding Memo: Extractive Memorization in Constrained Sequence Generation Tasks

![Teaser Image for the Paper][teaser]

Code for the [Paper][paper] "[Finding Memo: Extractive Memorization in Constrained Sequence Generation Tasks][website]" by [Vikas Raunak][Vikas] and [Arul Menezes][Arul].

This repo provides:

- Data, Model and Code to Replicate the results in the paper
- Scripts to Train and Run the experiments on your own dataset
- Pointers to modify the underlying algorithms

If you find our code or paper useful, please cite the paper:
```
@inproceedings{raunak-etal-finding-memo,
    title = "Finding Memo: Extractive Memorization in Constrained Sequence Generation Tasks",
    author = "Raunak, Vikas and Arul, Menezes",
    booktitle = "Findings of the Association for Computational Linguistics: EMNLP 2022",
    publisher = "Association for Computational Linguistics",
    year = "2022"
}
```

## Replicate the Results in the Paper

The code is tested in a conda environment with `python=3.8`.

```bash
pip install -r requirements.txt
wget https://www.dropbox.com/s/dxnlwziqzr9iz7i/data.zip
unzip data.zip
bash run_experiment.sh
```

## Train and Run the Experiments on your own Model

The directory and file paths could be set as per your custom setup.

```bash
bash train_spm.sh
bash train.sh
```

## Modify the Underlying Algorithms for Further Experiments

#### Change the threshold for Memorization Extraction (Algorithm 1)

This threshold could be set in `src/compute_dist.py`.

#### Apply Memorization Extraction (Algorithm 1) on CJKT languages

CJKT flag could be set to true in `src/compute_dist.py` for working with CJKT languages on the source side.

#### Change the Masked Language Model to Estimate Neighborhood Effect (Algorithm 2)

Different Masked Language Models could be defined and imported from `src/get_substitutions.py`.

#### Obtain the Data for Model Finetuning through the Memorization Mitigation (Algorithm 3)

The finetuning data could be obtained by running `scripts/augment.sh`.

#### Change the Recovery Symbol for Memorization Mitigation (Algorithm 3)

The recovery symbol is set in `scripts/augment.sh` as the `symbol` variable.

#### Transferable Memorization Attack Examples

A couple of examples on Microsoft Bing Translator and Google Translator are presented at this [link][website].

Please leave issues for any questions about the paper or the code.

[paper]: https://www.dropbox.com/s/56qmro92j8ijwhg/finding_memo.pdf
[teaser]: img/google_1.gif
[website]: https://vyraun.github.io/Finding-Memo/
[Vikas]: http://vyraun.github.io/
[Arul]: https://www.microsoft.com/en-us/research/people/arulm/
