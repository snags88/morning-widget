module TweetHelper

  def generate_twitter_container
    if oauth?
      render :partial => 'users/tweet', :collection => @twitter.get_feed
    else
      "<h3 class='text-center'>Not connected to Twitter</h3>".html_safe
    end
  end

end