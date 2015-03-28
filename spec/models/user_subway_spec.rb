require 'rails_helper'

RSpec.describe UserSubway, :type => :model do

  describe "a new user_subway" do
    it "has a valid factory" do
      expect(create(:user_subway)).to be_valid
    end

    it "is invalid without a user" do
      user_subway = build(:user_subway, :user => nil)
      expect(user_subway).not_to be_valid
    end

    it "is invalid without a subway" do
      user_subway = build(:user_subway, :subway => nil)
      expect(user_subway).not_to be_valid
    end

    context "associations" do
      let(:user_subway){create(:user_subway)}

      it "knows about its user" do
        expect(user_subway.user).to eq(User.last)
      end

      it "knows about its subway" do
        expect(user_subway.subway).to eq(Subway.last)
      end

      it "joins user and subway tables" do
        user = user_subway.user
        subway = user_subway.subway
        expect(user.subways).to include(subway)
      end
    end
  end

end