module SessionsHelper

  def link_to_twitter_sign_in
    link_to('<i class="icon-twitter"></i>'.html_safe+' Sign in with Twitter', '/auth/twitter', class: 'btn btn-primary')
  end

end