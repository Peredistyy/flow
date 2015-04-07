require 'rails_helper'

RSpec.describe TasksController, :type => :controller do
  describe 'POST #create' do
    it 'responds JSON' do
      current_user = login_user

      project = create :project, user_id: current_user.id
      post :create, project: { id: project.id }, task: { title: 'MyTask', done: true, deadline: '1989-03-21' }

      expected = { success: true, task: project.tasks.first }
      expect(response.body).to eq(expected.to_json)
    end
  end

  describe 'PUT #update' do
    it 'responds JSON' do
      current_user = login_user

      task = create :task, user_id: current_user.id

      put :update, id: task.id, task: { title: 'NEWTaskTitle' }

      task.reload
      expect(task.title).to eq('NEWTaskTitle')

      expected = { success: true }
      expect(response.body).to eq(expected.to_json)
    end
  end

  describe 'DELETE #destroy' do
    it 'responds JSON' do
      current_user = login_user
      task = create :task, title: 'TaskTitle', user_id: current_user.id

      delete :destroy, id: task.id

      expect(Task.exists?(task)).to be false

      expected = { success: true }
      expect(response.body).to eq(expected.to_json)
    end
  end

  describe 'POST #resorted' do
    it 'responds JSON' do
      current_user = login_user

      task1 = create :task, title: 'Task1', user_id: current_user.id, order: 1
      task2 = create :task, title: 'Task2', user_id: current_user.id, order: 2
      task3 = create :task, title: 'Task3', user_id: current_user.id, order: 3

      post :resorted, tasks: [ { id: task1.id, order: 3 }, { id: task2.id, order: 2 }, { id: task3.id, order: 1 } ]

      task1.reload
      expect(task1.order).to eq(3)
      task2.reload
      expect(task2.order).to eq(2)
      task3.reload
      expect(task3.order).to eq(1)

      expected = { success: true }
      expect(response.body).to eq(expected.to_json)
    end
  end
end