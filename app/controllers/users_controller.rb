class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :set_mta, only: [:show]

  def new
  end

  def create
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

  private
    def user_params
      params.require(:user).permit(:name, :zipcode, :subway_ids => [])
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_mta
      @mta = MTA.new
    end
end
