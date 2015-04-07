require 'rails_helper'

RSpec.describe Comment, :type => :model do
  it 'as json' do
    comment = create :comment

    expected = {
        id: comment.id,
        message: comment.message,
        attach_file_name: comment.attach_file_name,
        attach_url: comment.attach_url
    }

    expect(comment.to_json).to eq(expected.to_json)
  end

  it 'message presence' do
    comment = build :comment, message: ''

    expect(comment).not_to be_valid
  end
end