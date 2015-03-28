require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  describe "GET #new" do
    it "sets a new identity to @identity" do
      get :new
      expect(assigns(:identity)).to be_a(Identity)
    end
  end

  describe "GET #destroy" do
    it "logs the user out" do
      get :destroy
      expect(session[:user_id]).to eq(nil)
    end

    it "redirects to login page" do
      get :destroy
      expect(response).to redirect_to(root_path)
    end
  end

  describe "#new_user?" do
    it "returns true when user is new" do
      user = User.new
      expect(controller.send(:new_user?, user)).to eq(true)
    end

    it "returns false when user exists" do
      user = create(:user)
      expect(controller.send(:new_user?, user)).to eq(false)
    end
  end

end