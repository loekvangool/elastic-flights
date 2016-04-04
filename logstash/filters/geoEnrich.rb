# Call this file 'dcCabiGeo.rb' (in logstash/filters, as above)
require "logstash/filters/base"
require "logstash/namespace"

class LogStash::Filters::GeoEnrich < LogStash::Filters::Base


  # filter {
  #   geoEnrich { ... }
  # }
  config_name "geoEnrich"

  # New plugins should start life at milestone 1.
  milestone 1
  
  # the location of the location file which pairs station names or 
  # numbers to lat,lon geo locations 
  config :database, :validate => :path

  # the field from which we get the location's name
  config :source, :validate => :string, :required => true

  # the field in which we put the derived location
  config :target, :validate => :string, :default => 'location'

  config :locs 

  public
  def register
    #@logger.error("I Got Here: Register")
    if @database.nil?
      @database = LogStash::Environment.vendor_path("geoEnrich/cabiLocs.csv")
      if !File.exists?(@database)
        raise "You must specify 'database => ...' in your geoEnrich filter (I looked for '#{@database}'"
      end
    end
    #@logger.error("Using geo database: ", :path => @database)
    
    @locs = Hash.new
    CSV.foreach(@database) do |row|
      # use row here...
      @locs[row[4]] = [ row[7].to_f, row[6].to_f ] # { "lat" => row[1].to_f, "lon" => row[2].to_f }
    end
    
  end # def register
  

  public
  def filter(event)
    # return nothing unless there's an actual filter event
    return unless filter?(event)

    #@logger.error("Source: ", {:key => @source, :value => event[@source] } )
    if event[@source]
      #@logger.error( @locs )
      loc = event[@source]
      if @locs[loc]
        #@logger.error("found location", {:loc => loc, :value => @locs[loc] })
        event[@target] = @locs[loc]
      else
        @logger.error("Unmapped location: ", {"loc" => loc})
      end
    end
    #@logger.error("I Got Here: Done")
    # filter_matched should go in the last line of our successful code 
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Foo
