FactoryGirl.define do
  factory :identity do |f|
    f.sequence(:name) {|n| "test user#{n}"}
    f.sequence(:email) {|n| "test_user#{n}@test.com"}
    f.password "my secret password"
    f.password_confirmation {|u| u.password}
  end
end