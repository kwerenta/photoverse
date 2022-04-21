class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: %i[update destroy]
  before_action :require_permission, only: %i[update destroy]

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: "Comment has been created."
    else
      redirect_to post_path(@post), alert: "Comment has not been created."
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: "Comment has been updated."
    else
      redirect_to post_path(@post), alert: "Comment has not been updated."
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def require_permission
    redirect_to post_path(@post) if @comment.user != current_user
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
