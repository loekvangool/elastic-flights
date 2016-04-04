#!/bin/bash

# @description Load CSV'ed TSA Claims data into logstash
# @author loek.vangool@elastic.co

cat data/tsaclaims/claims-2014.cleaned.csv | sed -e "1d" | logstash -f import_tsaclaims.conf -w 2 --pluginpath .

echo "Done"
