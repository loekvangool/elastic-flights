#!/bin/bash

START=2014 # First year of data
END=2014 # Last year of data

mkdir -p data/tsa_claims
mkdir -p data/weather

END=`expr ${END} + 1`

while [ $START -lt ${END} ]; do
	wget -P data http://tsdata.bts.gov/PREZIP/On_Time_On_Time_Performance_${START}_1.zip
	wget -P data http://tsdata.bts.gov/PREZIP/On_Time_On_Time_Performance_${START}_2.zip
	wget -P data http://tsdata.bts.gov/PREZIP/On_Time_On_Time_Performance_${START}_3.zip
	wget -P data http://tsdata.bts.gov/PREZIP/On_Time_On_Time_Performance_${START}_4.zip
	wget -P data http://tsdata.bts.gov/PREZIP/On_Time_On_Time_Performance_${START}_5.zip
	wget -P data http://tsdata.bts.gov/PREZIP/On_Time_On_Time_Performance_${START}_6.zip
	wget -P data http://tsdata.bts.gov/PREZIP/On_Time_On_Time_Performance_${START}_7.zip
	wget -P data http://tsdata.bts.gov/PREZIP/On_Time_On_Time_Performance_${START}_8.zip
	wget -P data http://tsdata.bts.gov/PREZIP/On_Time_On_Time_Performance_${START}_9.zip
	wget -P data http://tsdata.bts.gov/PREZIP/On_Time_On_Time_Performance_${START}_10.zip
	wget -P data http://tsdata.bts.gov/PREZIP/On_Time_On_Time_Performance_${START}_11.zip
	wget -P data http://tsdata.bts.gov/PREZIP/On_Time_On_Time_Performance_${START}_12.zip
	let START=START+1
done

# TSA CLAIMS DATA
# We use a cleaned version of this data
#wget -P data/tsa_claims https://www.dhs.gov/sites/default/files/publications/claims-2014.xls
#wget -P data/tsa_claims https://www.dhs.gov/sites/default/files/publications/claims-2010-2013_0.xls
#wget -P data/tsa_claims https://www.dhs.gov/sites/default/files/publications/claims-2007-2009_0.xls
#wget -P data/tsa_claims https://www.dhs.gov/sites/default/files/publications/claims-2002-2006_0.xls
