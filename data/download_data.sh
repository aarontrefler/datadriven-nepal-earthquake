#!/bin/sh
wget -P raw/ https://s3.amazonaws.com/drivendata/data/57/public/train_labels.csv
wget -P raw/ https://s3.amazonaws.com/drivendata/data/57/public/train_values.csv
wget -P raw/ https://s3.amazonaws.com/drivendata/data/57/public/test_values.csv
wget -P raw/ https://s3.amazonaws.com/drivendata/data/57/public/submission_format.csv
