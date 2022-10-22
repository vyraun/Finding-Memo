from transformers import pipeline

# NLTK for roberta only, I forgot what I was doing :(
#import nltk
#from nltk.corpus import stopwords
#stop_words = stopwords.words('english')

bert_unmasker = pipeline('fill-mask', model='bert-base-cased')
roberta_unmasker = pipeline('fill-mask', model='roberta-large')
mbert_unmasker = pipeline('fill-mask', model='bert-base-multilingual-cased')

# Define a function which takes in a sentence, takes a index and
# generates the substituted variants of the full sentence
# I can generate substitutions using multiple methods here
# I want to get 5 substitutions at each position

def get_bert_substitutions(sentence, position):
    tokens = sentence.split()
    assert position <= len(tokens), "Position cannot be greater than sentence length"
    tokens[position-1] = '[MASK]'
    masked_sentence = " ".join(tokens).strip()
    generated = bert_unmasker(masked_sentence)
    return [ x['sequence'] for x in generated ]

def get_mbert_substitutions(sentence, position):
    tokens = sentence.split()
    assert position <= len(tokens), "Position cannot be greater than sentence length"
    tokens[position-1] = '[MASK]'
    masked_sentence = " ".join(tokens).strip()
    generated = mbert_unmasker(masked_sentence)
    return [ x['sequence'] for x in generated ]

def get_roberta_substitutions(sentence, position):
    tokens = sentence.split()
    assert position <= len(tokens), "Position cannot be greater than sentence length"
    if tokens[position-1] in stop_words:
        return []
    else:
        tokens[position-1] = '<mask>'
    masked_sentence = " ".join(tokens).strip()
    generated = roberta_unmasker(masked_sentence)
    return [ x['sequence'] for x in generated ]
