require 'open-uri'

class Wunderground
  URL = "http://api.wunderground.com/api/#{ENV['WUNDERGROUND_KEY']}/hourly/q/"

  attr_accessor :api_call, :weather_json

  def initialize(zip)
    self.api_call = URL + "#{zip}.json"
    open_url
  end

  def open_url
    self.weather_json = JSON.load(open(self.api_call))["hourly_forecast"]
  end

  def current_weather
    current_hour = self.weather_json[0]
    [get_weather(current_hour)]
  end

  def forecast_weather
    self.weather_json[1..10].collect do |hourly_hash|
      get_weather(hourly_hash)
    end
  end

  def get_weather(hourly_hash)
    {"hour" => get_hour(hourly_hash),
    "temp" => get_temp(hourly_hash),
    "condition" => get_condition(hourly_hash)}
  end

  def get_hour(hourly_hash)
    hourly_hash["FCTTIME"]["hour"]
  end

  def get_temp(hourly_hash)
    hourly_hash["temp"]["english"]
  end

  def get_condition(hourly_hash)
    hourly_hash["condition"]
  end
end

# We wanted to store our data like so:
#  current_weather = [
#   {:hour => 8,
#    :temp => 43,
#    :condition => "cloudy"}]
#
# forecast_weather = [
#   {:hour => 9,
#    :temp => 45,
#    :condition => "cloudy"},
#   {:hour => 10,
#    :temp => 46,
#    :condition => "cloudy"},
#    ...
# ]
