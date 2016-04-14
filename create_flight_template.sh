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

echo "Removing flights template"
curl ${AUTH_STRING} -XDELETE ${ES_URL}/_template/flights
echo 
echo "Adding flights template"
curl ${AUTH_STRING} -XPUT ${ES_URL}/_template/flights -d @mapping_flights.json
echo
