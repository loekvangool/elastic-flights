!#/bin/bash

# @author loek@elastic.co
# @description Downloads data sources from public internet using wget
# 			   Links were valid in March 2016

# FLIGHTS DATA

START=2010; # First year of data

mkdir -p data/tsa_claims
mkdir -p data/weather

while [ $START -lt 2015 ]; do
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
wget -P data/tsa_claims https://www.dhs.gov/sites/default/files/publications/claims-2014.xls
wget -P data/tsa_claims https://www.dhs.gov/sites/default/files/publications/claims-2010-2013_0.xls
wget -P data/tsa_claims https://www.dhs.gov/sites/default/files/publications/claims-2007-2009_0.xls
wget -P data/tsa_claims https://www.dhs.gov/sites/default/files/publications/claims-2002-2006_0.xls

# WEATHER DATA

# metadata:
# WSF2 - Fastest 2-minute wind speed (tenths of meters per second)
# WSF5 - Fastest 5-second wind speed (tenths of meters per second)
# SNOW - Snowfall (mm)
# WT03 - Thunder
# WT04 - Ice pellets, sleet, snow pellets, or small hail" 
# PRCP - Precipitation (tenths of mm)
# WT05 - Hail (may include small hail)
# TOBS - Temperature at the time of observation (tenths of degrees C)
# WT06 - Glaze or rime 
# WT07 - Dust, volcanic ash, blowing dust, blowing sand, or blowing obstruction
# WT08 - Smoke or haze 
# SNWD - Snow depth (mm)
# WDF2 - Direction of fastest 2-minute wind (degrees)
# AWND - Average daily wind speed (tenths of meters per second)
# WDF5 - Direction of fastest 5-second wind (degrees)
# WT11 - High or damaging winds
# WT01 - Fog, ice fog, or freezing fog (may include heavy fog)
# TMAX - Maximum temperature (tenths of degrees C)
# WT02 - Heavy fog or heaving freezing fog (not always distinguished from fog)
# PSUN - Daily percent of possible sunshine (percent)
# TMIN - Minimum temperature (tenths of degrees C)
# TSUN - Daily total sunshine (minutes)


