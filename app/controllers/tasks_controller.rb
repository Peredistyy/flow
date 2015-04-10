class TasksController < ApplicationController

  before_action :authenticate_user!, only: [:resorted]
  load_and_authorize_resource only: [:create, :update, :destroy]

  def create
    @task.project = current_user.projects.find(project_params[:id])

    if @task.save
      render json: { success: true, task: @task }
    else
      render json: { success: false, errors: @task.errors.full_messages }
    end
  end

  def update
    render json: { success: @task.update(task_params) }
  end

  def destroy
    @task.destroy
    render json: { success: @task.destroyed? }
  end

  def resorted
    resorted_params.each do |task_data|
      task = current_user.tasks.find task_data['id']
      task.order = task_data['order']
      task.save
    end

    render json: { success: true }
  end

  private

    def resorted_params
      params.require(:tasks)
    end

    def task_params
      params.require(:task).permit(:title, :done, :deadline)
    end

    def project_params
      params.require(:project).permit(:id)
    end

end