class ProjectsController < ApplicationController

  load_and_authorize_resource only: [:create, :update, :destroy]

  def index
    render json: { success: true, projects: Project.accessible_by(current_ability) }
  end

  def create
    if @project.save
      render json: { success: true, project: @project }
    else
      render json: { success: false, errors: @project.errors.full_messages }
    end
  end

  def update
    render json: { success: @project.update(project_params) }
  end

  def destroy
    @project.destroy
    render json: { success: @project.destroyed? }
  end

  private

    def project_params
      params.require(:project).permit(:title)
    end

end