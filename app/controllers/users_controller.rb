class UsersController < ApplicationController
  before_action :set_user, :authorization_action, only: [:show, :edit, :update, :destroy]
  before_action :set_mta, :set_weather, :set_news, :set_twitter, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to dashboard_path(@user)
    else
      #=> TODO add flash message
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user #=> TODO add message to action
    else
      render :edit #=> TODO add message to action
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, :notice => 'Removed Account'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :zipcode, :password, :password_confirmation, :subway_ids => [])
    end

    def authorization_action
      if !authorized?
        flash[:notice] = "You must be logged in to perform that action."
        redirect_to root_path
      end
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_mta
      @mta = MTA.new
    end

    def set_weather
      @weather = Wunderground.new(@user.zipcode)
    end

    def set_news
      @news = NewYorkTimes.new
    end

    def set_twitter
      @twitter = Twitter_helper.new(@user.token, @user.secret)
    end

end
