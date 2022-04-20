class ProfilesController < ApplicationController
  before_action :set_user
  before_action :set_posts

  def show; end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def set_posts
    @posts = Post.where(user: @user)
  end
end
