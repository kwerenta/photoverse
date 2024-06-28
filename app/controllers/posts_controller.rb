class PostsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_post, except: %i[index create explore]
  before_action :require_permission, only: %i[edit update destroy]

  # GET /posts or /posts.json
  def index
    @posts = Post.with_attached_photos
      .by_followed_users(current_user)
      .includes({user: {photo_attachment: :blob}})
  end

  def explore
    @posts = Post.with_attached_photos.includes({user: {photo_attachment: :blob}})

    render "index"
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comments = @post.comments.order(created_at: :desc).includes(%i[user replies])
  end

  # GET /posts/1/edit
  def edit
  end

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
      format.html { redirect_to root_path, notice: "Post was successfully destroyed." }
    end
  end

  private

  def require_permission
    redirect_to post_url(@post) if @post.user != current_user
  end

  def set_post
    @post = Post.with_attached_photos.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:caption, photos: [])
  end
end
