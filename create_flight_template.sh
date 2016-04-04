#!/bin/sh

echo "Removing and adding flights template"
curl -XDELETE http://localhost:9200/_template/flights-dev
curl -XPUT http://localhost:9200/_template/flights-dev -d @mapping_flights.json
echo
