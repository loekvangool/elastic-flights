#!/bin/sh

ES_URL=${1}

if [[ -z ${ES_URL} ]]; then
	echo "Usage: ${0} URL:PORT"
	exit
fi

curl -XDELETE ${ES_URL}/flights-*
curl -XDELETE ${ES_URL}/_template/flights
curl -XDELETE ${ES_URL}/_indices/all-flights
echo
