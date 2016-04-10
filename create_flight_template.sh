#!/bin/sh

ES_URL=${1}

if [[ -z ${ES_URL} ]]; then
	echo "Usage: ${0} URL:PORT"
	exit
fi

echo "Removing flights template"
curl -XDELETE ${ES_URL}/_template/flights-dev
echo 
echo "Adding flights template"
curl -XPUT ${ES_URL}/_template/flights-dev -d @mapping_flights.json
echo
