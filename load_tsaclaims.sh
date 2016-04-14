#!/bin/bash

cat data/tsaclaims/claims-2014.cleaned.csv | sed -e "1d" | logstash -f import_tsaclaims.conf --pluginpath .

echo "Done"
