include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :comment do
    message 'message'
    attach { fixture_file_upload(Rails.root.join('spec/fixtures/comment_attach.png'), 'image/png') }
    association :user
    association :task
  end
end