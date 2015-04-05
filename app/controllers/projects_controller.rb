class ProjectsController < ApplicationController

  before_action :authenticate_user!

  def index
    render json: { success: true, projects: current_user.projects }
  end

  def create
    @project = current_user.projects.new project_params

    if @project.save
      render json: { success: true, project: @project }
    else
      render json: { success: false, errors: @project.errors.full_messages }
    end
  end

  def update
    @project = Project.find(params[:id])

    if can?(:update, @project) && @project.update(project_params)
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  def destroy
    @project = Project.find(params[:id])

    if can?(:destroy, @project) && @project.destroy
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  private

  def project_params
    params.require(:project).permit(:title)
  end

end