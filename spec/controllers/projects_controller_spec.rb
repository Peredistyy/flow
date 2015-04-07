require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  describe 'GET #index' do
    it 'responds JSON' do
      current_user = login_user
      create :project, user_id: current_user.id

      get :index

      expected = { success: true, projects: current_user.projects }

      expect(response.body).to eq(expected.to_json)
    end
  end

  describe 'POST #create' do
    it 'responds JSON' do
      current_user = login_user

      post :create, project: { title: 'ProjectTitle' }

      expected = { success: true, project: current_user.projects.first }

      expect(response.body).to eq(expected.to_json)
    end
  end

  describe 'PUT #update' do
    it 'responds JSON' do
      current_user = login_user
      project = create :project, title: 'ProjectTitle', user_id: current_user.id

      put :update, id: project.id, project: { title: 'NEWProjectTitle' }

      project.reload
      expect(project.title).to eq('NEWProjectTitle')

      expected = { success: true }
      expect(response.body).to eq(expected.to_json)
    end
  end

  describe 'DELETE #destroy' do
    it 'responds JSON' do
      current_user = login_user
      project = create :project, title: 'ProjectTitle', user_id: current_user.id

      delete :destroy, id: project.id

      expect(Project.exists?(project)).to be false

      expected = { success: true }
      expect(response.body).to eq(expected.to_json)
    end
  end
end