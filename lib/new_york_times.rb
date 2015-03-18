require 'open-uri'

class NewYorkTimes

  URL = "http://api.nytimes.com/svc/topstories/v1/home.json?api-key=afa60c05354632ca201743143213c48b:6:71583923"

  attr_accessor :news_json, :api_call

  def initialize
    self.api_call = URL
    open_url
  end

  def open_url
    self.news_json = JSON.load(open(self.api_call))["results"]
  end
  
  def top_5_news_stories
    self.news_json[0..4].collect do |news_hash|
      get_news(news_hash)
    end
  end

  def get_news(news_hash)
    {"headline" => get_title(news_hash),
     "url" => get_url(news_hash)}
  end

  def get_title(news_hash)
    news_hash["title"]
  end

  def get_url(news_hash)
    news_hash["url"]
  end
end





