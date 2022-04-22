class UsersController < ApplicationController
  before_action :set_user
  before_action :set_posts, only: [:profile]

  def profile; end

  def follow_user
    redirect_to profile_path(@user.username) if Follow.create(following_id: @user.id, follower_id: current_user.id)
  end

  def unfollow_user
    redirect_to profile_path(@user.username) if Follow.destroy_by(following_id: @user.id, follower_id: current_user.id)
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end

  def set_posts
    @posts = Post.where(user: @user).includes(%i[user photos_attachments])
  end
end
