class TasksController < ApplicationController

  before_action :authenticate_user!

  def create
    @project = current_user.projects.find project_params[:id]
    @task = @project.tasks.new task_params
    @task.user = @project.user

    if @task.save
      render json: { success: true, task: @task }
    else
      render json: { success: false, errors: @task.errors.full_messages }
    end
  end

  def update
    @task = Task.find(params[:id])

    if can?(:update, @task) && @task.update(task_params)
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  def destroy
    @task = Task.find(params[:id])

    if can?(:destroy, @task) && @task.destroy
      render json: { success: true }
    else
      render json: { success: false }
    end
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