FactoryGirl.define do
  factory :subway do
    name {MTA::LINES.sample}
  end
end