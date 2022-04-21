class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many_attached :photos

  validates :caption, length: {maximum: 2200}

  def photo_as_thumbnail(photo)
    photo.variant(resize_to_fit: [256, 256]).processed
  end

  def photo_as_original(photo)
    photo.variant(resize_to_fit: [512, 512]).processed
  end
end
