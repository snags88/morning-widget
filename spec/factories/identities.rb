FactoryGirl.define do
  factory :identity do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {Faker::Internet.password}
    password_confirmation {|u| u.password}
  end

  factory :invalid_identity, :parent => :identity do
    email nil
  end
end