# Elastic Stack demo for airline data
US Domestic Flights ETL flow with weather, geo, delays, airlines for the country's top 5 airports. Uses Logstash, Elasticsearch &amp; Kibana.

As added bonus, there is a separate data set with 2014 TSA claims data.

I have made a [blog post](http://loekvangool.nl/TBD) explaining the process in more detail.
## Running the demo
Complete these steps:
1. Download data:
sh wget.sh
Data size is about 2.5 GB for both TSA and flights data. Because of filtering, size in Elasticsearch will be much lower, below 100 MB.
2. Create Elasticsearch indices and templates:
sh create_flight_template.sh && sh create_tsaclaims_index.sh
3. Ingest flight data into Elasticsearch with Logstash:
sh load_tsaclaims.sh && load_flights.sh
4. Import Kibana visuals and dashboards:
TODO
## Prerequisites
1. Elasticsearch 2.3
2. Kibana 4.4
3. Logstash 2.3
Other versions may work but are untested. If it turns out it works, please consider letting us know by making a pull request on this README.
## What's included
1. create_*.sh: sets up Elasticsearch templates, mappings (actual mappings in mapping*.json) and aliases
2. lookup_data/*: airport timezone and weather data for enriching the flight data
3. logstash/filters/*.rb: four simple Logstash filters to join the lookup data
3. load_*.sh: invoke Logstash to import the flat data files
4. remove_indices.sh: remove all indices, mappings, templates and 
5. wget.sh: downloads the flight data files
6. import_*.conf: configuration files for Logstash. Here, the host is hardcoded so change it to your needs
## Data sources
1. The [airline data](http://tsdata.bts.gov/PREZIP/) is taken from [US BTS](http://www.rita.dot.gov/bts/) and is limited to 2014 and the 5 busiest airports: ATL, ORD, JFK, LAX and DFW. Flights need one of these airports as both source as well as destination to qualify.
2. The [weather data](http://www.ncdc.noaa.gov/data-access/land-based-station-data) is taken from NOAA. For all 5 airports I used the closest weather station (in all cases, that means readings that are taken on the actual airport)
3. The timezone data was provided by [jpatokal](https://github.com/jpatokal/openflights)
