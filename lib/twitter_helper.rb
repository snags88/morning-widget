class Twitter_helper

  def initialize(access, secret)
  @client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['TWITTER_KEY']
    config.consumer_secret = ENV['TWITTER_SECRET']
    config.access_token = access
    config.access_token_secret = secret
    end
  end

  def get_feed
    feed = @client.home_timeline(:count => 12)

    feed.collect do |tweet|
      {"handle" => tweet.user.screen_name,
      "name" => tweet.user.name,
      "text" => tweet.text,
      "image_url" => tweet.user.profile_image_url.site +  tweet.user.profile_image_url.path,
      "created_at" => tweet.created_at} #=> call time_in_words in ActionView

    end

  end

end