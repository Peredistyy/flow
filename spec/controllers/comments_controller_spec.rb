require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  before do
    moke_current_ability
  end

  describe 'POST #create' do
    it 'responds JSON' do
      task = create :task, user_id: @current_user.id
      post :create, task: { id: task.id }, comment: { message: 'MyMessage' }

      expected = { success: true, comment: task.comments.first }
      expect(response.body).to eq(expected.to_json)
    end

    it 'cancan does not allow' do
      @ability.cannot :create, Comment
      post :create, { comment: attributes_for(:comment) }

      expect(response.body).to eq(access_denied_expected.to_json)
    end
  end

  describe 'DELETE #destroy' do
    it 'responds JSON' do
      comment = create :comment, user_id: @current_user.id

      delete :destroy, id: comment.id

      expect(Comment.exists?(comment)).to be false

      expected = { success: true }
      expect(response.body).to eq(expected.to_json)
    end

    it 'cancan does not allow' do
      comment = create :comment, user_id: @current_user.id
      @ability.cannot :destroy, comment
      post :destroy, id: comment.id

      expect(response.body).to eq(access_denied_expected.to_json)
    end
  end
end