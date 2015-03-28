FactoryGirl.define do
  factory :task do
    name {Faker::Lorem.sentence}
    user
  end
end