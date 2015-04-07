require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  describe 'POST #create' do
    it 'responds JSON' do
      current_user = login_user

      task = create :task, user_id: current_user.id
      post :create, task: { id: task.id }, comment: { message: 'MyMessage' }

      expected = { success: true, comment: task.comments.first }
      expect(response.body).to eq(expected.to_json)
    end
  end

  describe 'DELETE #destroy' do
    it 'responds JSON' do
      current_user = login_user
      comment = create :comment, user_id: current_user.id

      delete :destroy, id: comment.id

      expect(Comment.exists?(comment)).to be false

      expected = { success: true }
      expect(response.body).to eq(expected.to_json)
    end
  end
end