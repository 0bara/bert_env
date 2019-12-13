#
. $1
python $BERT_DIR/extract_features.py \
  --input_file=$WORK_DIR/input.txt \
  --output_file=$WORK_DIR/output.jsonl \
  --vocab_file=$BERT_MODEL_DIR/vocab.txt \
  --bert_config_file=$BERT_MODEL_DIR/bert_config.json \
  --init_checkpoint=$CHECKPOINT \
  --do_lower_case False \
  --layers -2

python  $BASE_DIR/bin/conv_tsv.py $WORK_DIR/output.jsonl $WORK_DIR/output.tsv

