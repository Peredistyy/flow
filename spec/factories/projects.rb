FactoryGirl.define do
  factory :project do
    sequence(:title) { |i| "title#{i}" }
    association :user
  end
end