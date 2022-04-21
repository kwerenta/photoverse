class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true

  after_commit :add_default_photo, on: %i[create update]

  def photo_as_avatar
    photo.variant(resize_to_fit: [32, 32]).processed
  end

  def photo_as_thumbnail
    photo.variant(resize_to_fit: [128, 128]).processed
  end

  private

  def add_default_photo
    return if photo.attached?

    photo.attach(
      io:           File.open(Rails.root.join("app", "assets", "images", "default_profile_photo.jpg")),
      filename:     "default_profile_photo.jpg",
      content_type: "image/jpg"
    )
  end
end
