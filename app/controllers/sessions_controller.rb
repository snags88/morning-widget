class SessionsController < ApplicationController

  def new
  end

  def create
    auth = request.env["omniauth.auth"]
    @user = User.set_user(auth)
    login(@user)
    redirect_to user_settings_path(@user), :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Signed out!"
    redirect_to root_path
  end

end

  # def create
  #   @user = User.find_by(:email => params[:email])
  #   if @user && @user.authenticate(params[:password])
  #     login(@user)
  #     redirect_to dashboard_path(@user)
  #   else
  #     flash.now[:notice] = "Invalid login. Please try again."
  #     render 'new'
  #   end
  # end
