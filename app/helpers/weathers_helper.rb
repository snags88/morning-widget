module WeathersHelper
  def get_icon(condition, hour)
    if condition["Clear"]
      hour > 5 && hour < 18 ? "icon-sun" : "icon-moon"
    elsif condition["Cloudy"]
      hour > 5 && hour < 18 ? "icon-cloud-sun" : "icon-cloud-moon"
    elsif condition["Overcast"]
      "icon-clouds"
    elsif condition["Snow"]
      "icon-snow-heavy"
    elsif condition["Rain"]
      "icon-rain"
    elsif condition["Thunderstorm"]
      "icon-flash-outline"
    else
      ""
    end
  end

  def hour_converter(hour)
    hour > 12 ? "#{hour - 12} pm" : "#{hour} am"
  end

  def weather_narrative(condition, hour)
    if condition["Clear"]
     hour > 5 && hour < 18 ? "Hey, it's lookin' good outside!" : "Good night! Remember to brush your teeth."
    elsif condition["Cloudy"]
     hour > 5 && hour < 18 ? "Gloomy day ahead, don't forget to smile!" : "Good night! Don't stay up too late."
    elsif condition["Overcast"]
      "Don't be fooled, it's going to be overcast. Leave those shades at home!"
    elsif condition["Snow"]
      "There's some snow outside. Wear you boots!"
    elsif condition["Rain"]
      "It's going to be drizzy outside, expect a Lil Wayne."
    elsif condition["Thunderstorm"]
      "Storm's a brewin'. Hopefully it's over in a flash!"
    else
      ""
    end
  end
end
