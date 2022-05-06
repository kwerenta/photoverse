module LikesHelper
  def get_like(likeable)
    current_user.likes.find_by(likeable: likeable)
  end

  def get_count(likeable)
    content_tag(:span, "text-sm") do
      number_to_human_shortcut(likeable.likes.size)
    end
  end
end
