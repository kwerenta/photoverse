class ProfileController < ApplicationController
  include ProfileHelper

  before_action :set_user
  before_action :set_posts, only: [:show]

  def show; end

  def follow
    Follow.create_or_find_by(following_id: @user.id, follower_id: current_user.id)
    render_follow_update
  end

  def unfollow
    Follow.destroy_by(following_id: @user.id, follower_id: current_user.id)
    render_follow_update
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end

  def set_posts
    @posts = Post.where(user: @user).includes([:user, {photos_attachments: :blob}])
  end

  def render_follow_update
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(follow_button_dom_id(@user),
                               partial: "profile/follow_button",
                               locals:  {user: @user}),
          turbo_stream.update(follow_counters_dom_id(@user),
                              partial: "profile/follow_counters",
                              locals:  {user: @user})
        ]
      end
    end
  end
end
