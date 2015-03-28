class UsersController < ApplicationController
  before_action :set_user, :authorization_action, only: [:show, :edit, :update, :destroy]
  before_action :set_apis, only: [:show]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to dashboard_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, :danger => 'Removed Account'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :zipcode, :password, :password_confirmation, :subway_ids => [])
    end

    def authorization_action
      if !authorized?
        flash[:danger] = "You must be logged in to perform that action."
        redirect_to root_path
      end
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_apis
      @mta = MTA.new
      @weathers = Wunderground.new(@user.zipcode)
      @news = NewYorkTimes.new
      @tasks = @user.ordered_tasks

      begin
          if oauth?
            @twitter = Twitter_helper.new(@user.token, @user.secret)
            @twitter_feed = @twitter.get_feed
            set_img
          end
      rescue TwitterErrorHandler
        @twitter_feed = [{ "handle" => "failWhale",
                              "name" => "Twitter Fail Whale",
                              "text" => "Too many requests! Try again in a few minutes.",
                              "image_url" => "https://pbs.twimg.com/profile_images/1193268828/failwhale.jpg",
                              "created_at" => Time.now
                            }]

      end
    end

    def set_img
      @user.image_url = @twitter.my_image
      @user.save
    end

end
