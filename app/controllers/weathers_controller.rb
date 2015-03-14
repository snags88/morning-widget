class WeathersController < ApplicationController
  def index
    @weathers = Weather.all

    if params[:search]
      @weathers.each do |weather|
        if weather.zipcode == Weather.find_by_zipcode(params[:search])
          @weather = Weather.find_by_zipcode(params[:search])
          redirect_to weather_path(@weather.id)
        else
          @weather = Wunderground.new("#{ENV['WUNDERGROUND_KEY']}") 
          # @w = Weather.newbuild
          # @weather.save
          redirect_to weather_path(@weather.id)
        end
      end
    else
      @weathers = Weather.all
    end
  end

  def create
    # @weathers = Weather.find(params[:id])
  end

end

