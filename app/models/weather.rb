# require 'pry'
# class Weather
#   require 'open-uri'

#   # Need to know which zip code you want tod hit - have the zip code as a parameter 
#   # Get the JSON for the hourly weather and store it in some sort of hash so we can access it by hour (basically what Seiji did in pry)
#   def initialize(zip_code)
#     BASE_URL = "http://api.wunderground.com/api/24eaf5c0bb2e4f25/geolookup/conditions/q"
#   end
  
#   BASE_URL = "http://api.wunderground.com/api/24eaf5c0bb2e4f25/hourly/q"


#   # open(url) do |f|

#   #   json_string = f.read
#   #   parsed_json = JSON.parse(json_string)
#   #   location = parsed_json['location']['city']
#   #   temp_f = parsed_json['current_observation']['temp_f']
#   #   print "Current temperature in #{location} is: #{temp_f}\n"
#   # end


#   def url(zip_code)
#     "#{BASE_URL}/#{zip_code}.json"
#   end

#   def get_json(url)
#     JSON.load(open(url))
#   end

# end

# binding.pry

# Weather.new(zip)