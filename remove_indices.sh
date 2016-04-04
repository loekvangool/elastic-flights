#!/bin/sh

curl -XDELETE http://localhost:9200/flights-*
curl -XDELETE http://localhost:9200/_template/flights
echo

