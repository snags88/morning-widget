require 'rails_helper'

RSpec.describe Task, :type => :model do

  describe "new task" do
    it "has a valid factory" do
      expect(create(:task)).to be_valid
    end

    it "is invalid without a name" do
      task = build(:task, :name => nil)
      expect(task).not_to be_valid
    end

    it "is invalid without a user" do
      task = build(:task, :user => nil)
      expect(task).not_to be_valid
    end

    it "knows about its user" do
      task = create(:task)
      expect(task.user).to be_a(User)
    end

  end
end