require 'rails_helper'

RSpec.describe Subway, :type => :model do

  describe "new subway" do
    it "has a valid factory" do
      expect(create(:subway)).to be_valid
    end

    it "is invalid without a name" do
      subway = build(:subway, :name => nil)
      expect(subway).not_to be_valid
    end

    it "is invalid without a valid subway line name" do
      subway = build(:subway, :name => "Some subway")
      expect(subway).not_to be_valid
    end
  end


end