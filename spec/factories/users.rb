FactoryGirl.define do

  factory :user do
    name {Faker::Name.name}
    zipcode {Faker::Address.zip_code.to_i}

    factory :user_with_tasks do
      transient do
        tasks_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:task, evaluator.tasks_count, user: user)
      end
    end

    factory :user_with_subways do
      transient do
        subways_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:user_subway, evaluator.subways_count, user: user)
      end
    end
  end

end
