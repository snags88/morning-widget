class IdentitiesController < ApplicationController
  def new
    @identity = env['omniauth.identity']
  end

  def create
    @identity = Identity.build_user_identity(identity_params)
    if @identity.save
      login(@identity.user)
      redirect_to user_settings_path(@identity.user), :notice => "Signed in!"
    end
  end

  private
    def identity_params
      params.require(:identity).permit(:name, :email, :password, :password_confirmation)
    end
end
