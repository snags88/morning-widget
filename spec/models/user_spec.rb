require 'rails_helper'

RSpec.describe User, :type => :model do

  context "new user" do
    it "has a valid factory" do
      expect(create(:user)).to be_valid
    end

    it "is valid with a blank zipcode" do
      user = build(:user, :zipcode => "")
      expect(user).to be_valid
    end

    it "is invalid without 5 digit zipcode" do
      user = build(:user, :zipcode => "1111")
      expect(user).not_to be_valid
    end


  end

end