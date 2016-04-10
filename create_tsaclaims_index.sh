#!/bin/bash

ES_URL=${1}

if [[ -z ${ES_URL} ]]; then
	echo "Usage: ${0} URL:PORT"
	exit
fi

echo "Adding tsaclaims index"
curl -XPUT ${ES_URL}tsaclaims -d @mapping_tsaclaims.json
echo
