class CommentsController < ApplicationController

  load_and_authorize_resource only: [:create, :destroy]

  def create
    @comment.task = current_user.tasks.find(task_params[:id])

    if @comment.save
      render json: { success: true, comment: @comment }
    else
      render json: { success: false, errors: @comment.errors.full_messages }
    end
  end

  def destroy
    @comment.destroy
    render json: { success: @comment.destroyed? }
  end

  private
    def comment_params
      params.require(:comment).permit(:message, :attach)
    end

    def task_params
      params.require(:task).permit(:id)
    end

end