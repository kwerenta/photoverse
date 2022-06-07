class Post < ApplicationRecord
  belongs_to :user, counter_cache: :posts_count

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :photos

  validates :caption, length: {maximum: 2200}

  default_scope { order(created_at: :desc) }

  scope :by_followed_users, lambda {|user|
                              joins("INNER JOIN follows ON posts.user_id = follows.following_id")
                                .where(follows: {follower_id: user})
                            }

  def photo_as_thumbnail(photo)
    photo.variant(resize_to_fit: [256, 256]).processed
  end

  def photo_as_original(photo)
    photo.variant(resize_to_fit: [512, 512]).processed
  end
end
