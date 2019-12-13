# Simple trial environment for BERT  
using Japanese pre-learning model

## overview
- As small as possible  
but almost 1.5Gbytes  
- Works with TensorFlow ver2.0.0  
using GPU is unconfirmed
- Targeting Japanese  
- Supports 3 pretrained model.
  1. [BERT Japanese Pretrained model normal version](http://nlp.ist.i.kyoto-u.ac.jp/index.php?BERT%E6%97%A5%E6%9C%AC%E8%AA%9EPretrained%E3%83%A2%E3%83%87%E3%83%AB)  
  1. [BERT Japanese Pretrained model Whole Word Masking version](http://nlp.ist.i.kyoto-u.ac.jp/index.php?BERT%E6%97%A5%E6%9C%AC%E8%AA%9EPretrained%E3%83%A2%E3%83%87%E3%83%AB)  
  1. [Japanese business news articles (3 million articles)](https://qiita.com/mkt3/items/3c1278339ff1bcc0187f)

  - But not included. Download it manually.  
- Morphological analysis uses Juman++(v2.0.0-rc3).  
 Included in this docker image.
- In the [original bert](https://github.com/google-research/bert), part of the code that uses tensorflow gives an error  
and replaced morphological analysis with juman++.  
So use the [modified version](https://github.com/0bara/bert)  
, included in this docker image.
## Execution
### Preparation
- Install docker and docker-compose
- Perform the following steps:
  ```bash
  $ git clone https://github.com/0bara/bert_env.git
  $ cd bert_env
  $ docker-compose build
  # The work directory is the location of input.txt and output files (output.jsonl, output.tsv).
  # So you can create a work directory and generate input.txt there.
  $ ln -s docker/bin work
  $ cd work
  $ ln -s input_ex1.txt input.txt
  $ cd ..
  $ mkdir model
  # Download data to use
  $ curl http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/JapaneseBertPretrainedModel/Japanese_L-12_H-768_A-12_E-30_BPE.zip -o model/Japanese_L-12_H-768_A-12_E-30_BPE.zip
  $ cd model
  $ unzip Japanese_L-12_H-768_A-12_E-30_BPE.zip
  $ cd ..
  ```

  ```bash
	$ tree
	.
	├── README.md
	├── docker
	│   ├── Dockerfile
	│   ├── bin
	│   │   ├── btest.sh
	│   │   ├── conv_tsv.py
	│   │   ├── elmo.env
	│   │   ├── input.txt -> input_ex1.txt
	│   │   ├── input_ex1.txt
	│   │   ├── input_ex2.txt
	│   │   ├── norm.env
	│   │   ├── output.jsonl
	│   │   ├── output.tsv
	│   │   └── wwm.env
	│   ├── jumanpp-2.0.0-rc3.tar.xz
	│   └── requirements.txt
	├── docker-compose.yml
	├── model
	│   ├── Japanese_L-12_H-768_A-12_E-30_BPE
	│   │   ├── README.txt
	│   │   ├── bert_config.json
	│   │   ├── bert_model.ckpt.data-00000-of-00001
	│   │   ├── bert_model.ckpt.index
	│   │   ├── bert_model.ckpt.meta
	│   │   └── vocab.txt
	│   └── Japanese_L-12_H-768_A-12_E-30_BPE.zip
	└── work -> docker/bin

  ```
## Execution

```bash
$ docker-compose up
```
 - As a result, `output.tsv` (output.jsonl) is output to the work directory.

## Visualization  
with [Embedding Projector](http://projector.tensorflow.org/)
- Press the load button in the left pane
- Specify output.tsv output in [Step 1: Load a TSV file of vectors]
- In [Step 2 (optional): Load a TSV file of metadata], specify input.txt

## Additional
### How to use Whole Word Masking model
- Extract Japanese_L-12_H-768_A-12_E-30_BPE_WWM.zip directly under the model directory
- Run the following command:  
  ```bash
  $ docker-compose run bert /bin/sh bin/btest.sh bin/wwm.env
  ```
### How to use Japanese business news articles model
- Download the data and place it in the model/Elmo directory.
- Run the following command:  
  ```bash
  $ docker-compose run bert /bin/sh bin/btest.sh bin/elmo.env
  ```
## Reference
- https://dev.classmethod.jp/machine-learning/bert-text-embedding/
- http://nlp.ist.i.kyoto-u.ac.jp/index.php?BERT%E6%97%A5%E6%9C%AC%E8%AA%9EPretrained%E3%83%A2%E3%83%87%E3%83%AB
- https://qiita.com/mkt3/items/3c1278339ff1bcc0187f


