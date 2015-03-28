require 'rails_helper'

RSpec.describe User, :type => :model do

  describe "new user" do
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

  describe "tasks" do
    let(:user){create(:user_with_tasks)}

    context "without tasks" do
      it "has a valid factory" do
        expect(create(:user)).to be_valid
      end
    end

    context "with tasks" do
      it "has a valid factory" do
        expect(user).to be_valid
      end
      it "accepts more tasks" do
        initial_task_count = user.tasks.length
        task = create(:task, :user => user)
        user.reload
        expect(user.tasks.length).to eq(initial_task_count + 1)
      end
    end

    context "user is destroyed" do
      it "removes associated tasks" do
        user.destroy
        task_count = Task.find_by(:user => user)
        expect(task_count).to eq(nil)
      end
    end

    context "#ordered_tasks" do
      it "returns tasks in newest to oldest order" do
        unordered_tasks = user.tasks
        ordered_tasks = user.ordered_tasks
        expect(ordered_tasks.first).to eq(unordered_tasks.last)
        expect(ordered_tasks.last).to eq(unordered_tasks.first)
      end
    end
  end

  describe "subways" do
    let(:user){create(:user_with_subways)}

    context "without subways" do
      it "has a valid factory" do
        expect(create(:user)).to be_valid
      end
    end

    context "with subways" do
      it "has a valid factory" do
        expect(user).to be_valid
      end

      it "accepts more subways" do
        initial_subway_count = user.subways.length
        create(:user_subway, :user => user)
        user.reload
        expect(user.subways.length).to eq(initial_subway_count + 1)
      end
    end

    context "user is destroyed" do
      it "removes associated subways" do
        user.destroy
        subway_count = user.subways.length
        expect(subway_count).to eq(0)
      end
    end

    context "#ordered_subways" do
      it "returns an array" do
        expect(user.ordered_subways).to be_a(Array)
      end

      it "returns subways in order of id" do
        ordered_subways = user.ordered_subways
        ordered_array = Subway.where(:name => ordered_subways).order(:id).pluck(:name)
        expect(ordered_subways).to eq(ordered_array)
      end
    end

  end
end