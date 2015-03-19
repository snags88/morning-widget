class IdentitiesController < ApplicationController
  def new
    @identity = Identity.new
  end

  def create
    @identity = Identity.build_user_identity(identity_params)
    if @identity.save
      login(@identity.user)
      redirect_to user_settings_path(@identity.user), :success => "Signed in!"
    else
      render 'sessions/new'
    end
  end

  private
    def identity_params
      params.require(:identity).permit(:name, :email, :password, :password_confirmation)
    end
end
