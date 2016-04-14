#!/bin/bash

# Load existing zipped airline data into logstash
#   Reduces disk usage by going file by file
#   Cuts first line of CSV file
#
# @author loek.vangool@elastic.co

mkdir -p "temp"
mkdir -p "data/done"

rm -v temp/*.csv

for file in data/*2014*.zip; do
	echo "Unpacking ${file}"
	unzip -o "${file}" -d ./temp/
	rm -v ./temp/readme.html
#	read -p "Go for logstash import? (y/N) " -r
#	if [[ $REPLY =~ ^[Yy]$ ]]
#	then
#		iconv -c -f iso-8859-1 -t temp/*.csv > temp/output.csv
		cat temp/*.csv | sed -e "1d" | logstash -f import_airlinedata.conf --pluginpath .
		mv -v ${file} data/done/
#		rm -v temp/output.csv
#	else
#		echo "Aborted"
#	fi
	rm -v temp/*.csv
	echo "-----------------------------------------------------------------------"
done

rm -r temp/
