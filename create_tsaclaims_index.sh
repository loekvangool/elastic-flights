#!/bin/bash

echo "Adding tsaclaims index"
curl -XPUT http://localhost:9200/tsaclaims -d @mapping_tsaclaims.json
echo
