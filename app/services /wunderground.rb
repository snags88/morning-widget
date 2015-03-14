require 'open-uri'

class Wunderground 

  def initialize(zip)
    URL = "http://api.wunderground.com/api/#{ENV['WUNDERGROUND_KEY']}/hourly/q/#{zip}.json" 
  end

  def open_url(URL)
    JSON.load(open(URL))
  end

  def get_current_temp(hourly_forecast_array)
    current_temp = hourly_forecast_array[0]["temp"]["english"]
  end

  def get_current_condition(hourly_forecast_array)
    current_temp = hourly_forecast_array[0]["condition"]
  end

  def get_hourly_temps(hourly_forecast_array)
    temps = []
    hourly_forecast_array.each do |hourly_weather_hash|
      temps << hourly_weather_hash["temp"]["english"]
    end
    temps
  end

  def get_hourly_conditions(hourly_forecast_array)
    conditions = []
    hourly_forecast_array.each do |hourly_weather_hash|
      temps << hourly_weather_hash["condition"]
    end
    conditions
  end

end

# We wanted to store our data like so:
# hourly_conditions: [
#   {:hour => 9},
#   {:temp => 45},
#   {:condition => "cloudy"}
# ]