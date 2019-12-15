#!/bin/bash

# If BERT file doesn't exist, download it.
BERT_DIR="${PWD}/bert/Japanese_L-12_H-768_A-12_E-30_BPE_WWM_transformers"
if [ ! -d "$BERT_DIR" ]; then
    echo "$BERT_DIR doesn't exist, downloading..."
    wget -P ${PWD}/bert http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/JapaneseBertPretrainedModel/Japanese_L-12_H-768_A-12_E-30_BPE_WWM_transformers.zip
    unzip ${PWD}/bert/Japanese_L-12_H-768_A-12_E-30_BPE_WWM_transformers.zip -d ${PWD}/bert
fi

# If Juman++ file doesn't exist, download it.
JUMAN_DIR="${PWD}/jumanpp-2.0.0-rc2"
if [ ! -d "$JUMAN_DIR" ]; then
    echo "$JUMAN_DIR doesn't exist, downloading..."
    wget https://github.com/ku-nlp/jumanpp/releases/download/v2.0.0-rc2/jumanpp-2.0.0-rc2.tar.xz
    tar Jxfv jumanpp-2.0.0-rc2.tar.xz
fi

docker-compose build