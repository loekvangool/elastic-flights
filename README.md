# Elastic Stack demo for airline data
US Domestic Flights ETL flow with weather, geo, delays, airlines for the country's top 5 airports. Uses Logstash, Elasticsearch &amp; Kibana (with optionally the Kibana plugin Timelion).

As added bonus, there is a separate data set with 2014 TSA claims data.
## Running the demo
Complete these steps:

1. Download data:
    * `sh wget.sh`
    * Data size is about 2.5 GB. Because of filtering, size in Elasticsearch will be much lower, below 100 MB.
2. Create Elasticsearch indices and templates:
    * Optionally put a username/password in `import_*.conf`
    * `sh create_flight_template.sh && sh create_tsaclaims_index.sh`
3. Ingest flight data into Elasticsearch with Logstash:
    * `sh load_tsaclaims.sh && sh load_flights.sh`
4. Create an alias called `flights`, composed of all `flights-*` indices:
    * `sh create_flight_alias.sh`
5. Import Kibana visuals and dashboards:
   * In Kibana, go to `Settings`, then `Objects`, then Import `kibana_import.json`
   * Optional: Timelion is a time series graphing plugin for Kibana, developed by the people of Elastic. Read more about Timelion and how to get it [here](https://www.elastic.co/blog/timelion-timeline). Currently it is not possible to export or import Timelion sheets. To create some charts about this data, open Timelion and add the following code. For every line, add a Chart on the Timelion sheet and paste in the code for four different charts. Don't forget to save the sheet.
   
   `.es(index=flights).label("All Flights"), .es(index=flights, q=ArrDelayMinutes:>0).label("Delayed Flights")`

   `.static(55).color(red).label("Red Line"), .static(50).color(orange).label("Orange Line"), .es(index=flights, q=ArrDelayMinutes:>0).label("Delayed Flights Percentage").divide(.es(index=flights)).multiply(100).color(navy).movingaverage(5)`
   
   `.es(index=flights, metric=avg:tmax).color(orange).lines(width=2).movingaverage(5).label("Minimum Temperature (celsius) mavg=5"), .es(index=flights, metric=avg:tmin).color(lightblue).lines(width=2).movingaverage(5).label("Maximum Temperature (celsius) mavg=5"), .es(index=flights, metric=avg:WeatherDelay).color(Red).movingaverage(5).label("Weather Delay (in minutes) mavg=5")`
   
   `.es(index=flights, q=ArrDelayMinutes:>0).label("Delayed Flights Percentage").color(navy).movingaverage(10), .es(index=flights, metric=sum:terribility).label("Terribility Index").movingaverage(10)`

## Prerequisites
1. Elasticsearch 2.3
2. Kibana 4.4
3. Logstash 2.3
4. Timelion (optional)

Other versions may work but are untested. If it turns out it works, please consider letting us know by making a pull request on this README.

## What's included
1. `create_*.sh`: sets up Elasticsearch templates, mappings (actual mappings in mapping*.json) and aliases
2. `lookup_data/*`: airport timezone and weather data for enriching the flight data
3. `logstash/filters/*.rb`: four simple Logstash filters to join the lookup data
3. `load_*.sh`: invoke Logstash to import the flat data files
4. `remove_indices.sh`: remove all indices, mappings, templates and 
5. `wget.sh`: downloads the flight data files
6. `import_*.conf`: configuration files for Logstash. Here, the host is hardcoded so change it to your needs
7. `kibana_import.json`: Two Dashboards and 43 Visualizations for Kibana

## Data sources
1. The [airline data](http://tsdata.bts.gov/PREZIP/) is taken from [US BTS](http://www.rita.dot.gov/bts/) and is limited to 2014 and the 5 busiest airports: ATL, ORD, JFK, LAX and DFW. Flights need one of these airports as both source as well as destination to qualify.
2. The [weather data](http://www.ncdc.noaa.gov/data-access/land-based-station-data) is taken from [NCEI](http://www.ncdc.noaa.gov/). For all 5 airports I used the closest weather station (in all cases, that means readings that are taken on the actual airport)
3. The timezone data was provided by [jpatokal](https://github.com/jpatokal/openflights)