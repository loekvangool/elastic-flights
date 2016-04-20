#!/bin/sh

ES_URL=${1}
ES_AUTH=${2}

if [[ -z ${ES_URL} ]]; then
    echo "Usage: ${0} URL:PORT [USERNAME:PASSWORD]"
    exit
fi

if [ "${ES_AUTH}" ]; then
    AUTH_STRING="--user ${2}"
fi

curl ${AUTH_STRING} -XDELETE ${ES_URL}/flights-*
curl ${AUTH_STRING} -XDELETE ${ES_URL}/_template/flights
curl ${AUTH_STRING} -XDELETE ${ES_URL}/_indices/flights
echo
