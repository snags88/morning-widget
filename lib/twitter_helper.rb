class Twitter_helper

  attr_accessor :my_image

  def initialize(access, secret)
  @client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['TWITTER_KEY']
    config.consumer_secret = ENV['TWITTER_SECRET']
    config.access_token = access
    config.access_token_secret = secret
    end

  self.my_image = @client.user.profile_image_url.site + @client.user.profile_image_url.path
  end

  def get_feed
    feed = @client.home_timeline(:count => 12)

    feed.collect do |tweet|
      {"handle" => tweet.user.screen_name,
      "name" => tweet.user.name,
      "text" => tweet.text,
      "image_url" => tweet.user.profile_image_url.site +  tweet.user.profile_image_url.path,
      "created_at" => tweet.created_at}
    end
  end

end