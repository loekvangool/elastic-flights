#!/bin/sh

ES_URL=${1}
ES_AUTH=${2}
ES_AUTH=

if [[ -z ${ES_URL} ]]; then
	echo "Usage: ${0} URL:PORT [USERNAME:PASSWORD]"
	exit
fi

if [ -n ${ES_AUTH} ]; then
    AUTH_STRING="--user ${2}"
fi

echo 
echo "Adding/overwriting flights alias"
curl ${AUTH_STRING} -XPOST ${ES_URL}/_aliases -d '
{
    "actions" : [
        { "add" : { "index" : "flights-*", "alias" : "flights" } }
    ]
}'
echo
