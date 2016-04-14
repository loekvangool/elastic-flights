#!/bin/bash

ES_URL=${1}
ES_AUTH=${2}

if [[ -z ${ES_URL} ]]; then
    echo "Usage: ${0} URL:PORT [USERNAME:PASSWORD]"
    exit
fi

if [ "${ES_AUTH}" ]; then
    AUTH_STRING="--user ${2}"
fi

echo "Adding tsaclaims index"
curl ${AUTH_STRING} -XPUT ${ES_URL}/tsaclaims -d @mapping_tsaclaims.json
echo
