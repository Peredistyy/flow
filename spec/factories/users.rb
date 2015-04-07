FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "email#{i}@mail.com" }
    password 'password'
  end
end