FactoryGirl.define do
  factory :task do
    title 'title'
    association :project
    association :user
  end
end