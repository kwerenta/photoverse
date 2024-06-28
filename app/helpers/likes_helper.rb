module LikesHelper
  def get_like(likeable)
    current_user.likes.find_by(likeable: likeable)
  end
end
