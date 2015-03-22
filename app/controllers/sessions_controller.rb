class SessionsController < ApplicationController

  def new
    @identity = Identity.new
  end

  def create
    @user = build_user(request.env["omniauth.auth"])
    if @user && @user.save
      login(@user)
      flash[:success] = "Signed in!"
      if new_user?(@user)
        redirect_to user_settings_path(@user)
      else
        redirect_to dashboard_path(@user)
      end
    else
      @identity = Identity.new
      flash.now[:danger] = "Invalid login. Please try again."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Signed out!"
    redirect_to root_path
  end

  private
    def build_user(omni_hash)
      if omni_hash
        User.set_user(omni_hash)
      else
        identity = Identity.find_by(:email => params[:email])
        identity.user if identity && identity.authenticate(params[:password])
      end
    end

    def new_user?(user)
      !(user.zipcode)
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
