class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many_attached :photos do |photo|
    photo.variant :thumb, resize_to_fit: [250, 250]
    photo.variant :full, resize_to_fit: [500, 500]
  end

  validates :caption, length: {maximum: 2200}
end
