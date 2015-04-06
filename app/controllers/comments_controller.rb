class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @task = current_user.tasks.find task_params[:id]
    @comment = @task.comments.new comment_params
    @comment.user = @task.user

    if @comment.save
      render json: { success: true, comment: @comment }
    else
      render json: { success: false, errors: @comment.errors.full_messages }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if can?(:destroy, @comment) && @comment.destroy
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :attach)
  end

  def task_params
    params.require(:task).permit(:id)
  end

end