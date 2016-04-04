# Call this file 'dcCabiGeo.rb' (in logstash/filters, as above)
require "logstash/filters/base"
require "logstash/namespace"

class LogStash::Filters::WeatherEnrich < LogStash::Filters::Base


  # filter {
  #   geoEnrich { ... }
  # }
  config_name "weatherEnrich"

  # New plugins should start life at milestone 1.
  milestone 1
  
  # the location of the location file which pairs station names or 
  # numbers to lat,lon geo locations 
  config :database, :validate => :path

  # the field from which we get the location's name
  config :source, :validate => :string, :required => true

  # the field in which we put the derived location
  config :target, :validate => :string, :default => 'location'

  config :date, :validate => :string

  config :locs 

  config :precipitation
  config :snowdepth
  config :snowfall
  config :thunder
  config :hail
  config :glaze
  config :damaging_wind
  config :fog
  config :heavy_fog
  config :dust_ash
  config :tmin
  config :tmax

  # 0 WSF2 - Fastest 2-minute wind speed (tenths of meters per second)
  # WSF5 - Fastest 5-second wind speed (tenths of meters per second)
  # SNOW - Snowfall (mm)
  # WT03 - Thunder
  # WT04 - Ice pellets, sleet, snow pellets, or small hail" 
  # 5 PRCP - Precipitation (tenths of mm)
  # WT05 - Hail (may include small hail)
  # TOBS - Temperature at the time of observation (tenths of degrees C)
  # WT06 - Glaze or rime 
  # WT07 - Dust, volcanic ash, blowing dust, blowing sand, or blowing obstruction
  # 10 WT08 - Smoke or haze 
  # SNWD - Snow depth (mm)
  # WDF2 - Direction of fastest 2-minute wind (degrees)
  # AWND - Average daily wind speed (tenths of meters per second)
  # WDF5 - Direction of fastest 5-second wind (degrees)
  # 15 WT11 - High or damaging winds
  # WT01 - Fog, ice fog, or freezing fog (may include heavy fog)
  # TMAX - Maximum temperature (tenths of degrees C)
  # WT02 - Heavy fog or heaving freezing fog (not always distinguished from fog)
  # PSUN - Daily percent of possible sunshine (percent)
  # 20 TMIN - Minimum temperature (tenths of degrees C)
  # TSUN - Daily total sunshine (minutes)

  # STATION,
  # CODE,ELEVATION,LATITUDE,LONGITUDE,DATE,
  # PRCP,SNWD,SNOW,PSUN,TSUN,
  # TMAX,TMIN,AWND,WDF2,WDF5,
  # WSF2,WSF5,WT09,WT07,WT01,
  # WT06,WT05,WT02,WT04,WT08,
  # WT03

  public
  def register
    if @database.nil?
      if !File.exists?(@database)
        raise "You must specify 'database => ...' in your filter (I looked for '#{@database}'"
      end
    end
    #@logger.error("Using database: ", :path => @database)
    
    @locs = Hash.new
    CSV.foreach(@database) do |row|
      key = row[1] + row[5]
      @locs[key] = [ row[6].to_f, row[7].to_f, row[8].to_f, row[9].to_f, row[10].to_f, row[11].to_f, row[12].to_f, row[13].to_f, row[14].to_f, row[15].to_f, row[16].to_f, row[17].to_f, row[18].to_f, row[19].to_f, row[20].to_f, row[21].to_f, row[22].to_f, row[23].to_f, row[24].to_f, row[25].to_f, row[26].to_f ]
    end
    #@logger.error("My database: ", {:value => @locs } )
  end # def register
  

  public
  def filter(event)
    # return nothing unless there's an actual filter event
    return unless filter?(event)

    #@logger.error("Source: ", {:key => @source, :value => event[@source] } )
    if event[@source]
      #@logger.error( @locs )
      loc = event[@source]
      day = event[@date]
      day.gsub! '-', '' # replace dashes with nulls
      key = loc + day
      if @locs[key]
        #@logger.error("Found", {:key => key, :value => @locs[key] } )
        event[@precipitation] = @locs[key][0]
        event[@snowdepth] = @locs[key][1]
        event[@snowfall] = @locs[key][2]
        event[@thunder] = @locs[key][20]
        event[@hail] = @locs[key][16]
        event[@tmax] = @locs[key][5]
        event[@tmin] = @locs[key][6]
        event[@glaze] = @locs[key][15]
        event[@damaging_wind] = 0
        event[@heavy_fog] = @locs[key][17]
        event[@fog] = @locs[key][14]
        event[@dust_ash] = @locs[key][13]
        #event[@terribility] = @locs[key][2] + @locs[key][20] + @locs[key][16] + @locs[key][15] + @locs[key][17] + @locs[key][14] + @locs[key][13]
        #@logger.error("Filled event", {:key => key, :value => event } )
      else
        @logger.error("Unmapped key: ", {"key" => key})
      end
    end
    #@logger.error("I Got Here: Done")
    # filter_matched should go in the last line of our successful code 
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Foo
