class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(:email => params[:email])
    if @user && @user.authenticate(params[:password])
      login(@user)
      redirect_to dashboard_path(@user)
    else
      flash.now[:notice] = "Invalid login. Please try again."
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

end