class PostsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_post, except: %i[index new create]
  before_action :require_permission, only: %i[edit update destroy]

  # GET /posts or /posts.json
  def index
    @posts = Post.all.includes([{photos_attachments: :blob},
                                {user: {photo_attachment: :blob}}]).order(created_at: :desc)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comments = @post.comments.order(created_at: :desc).includes([:user])
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
    end
  end

  def like_post
    redirect_back(fallback_location: root_path) if Like.create(post: @post, user: current_user)
  end

  def unlike_post
    redirect_back(fallback_location: root_path) if Like.destroy_by(post: @post, user: current_user)
  end

  private

  def require_permission
    redirect_to post_url(@post) if @post.user != current_user
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:caption, photos: [])
  end
end
