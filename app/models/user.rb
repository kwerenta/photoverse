class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :received_follows, foreign_key: :following_id, class_name: "Follow", dependent: :destroy, inverse_of: :user
  has_many :followers, through: :received_follows, source: :follower
  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow", dependent: :destroy, inverse_of: :user
  has_many :followings, through: :given_follows, source: :following

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
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
      io: Rails.root.join("app/assets/images/default_profile_photo.jpg").open,
      filename: "default_profile_photo.jpg",
      content_type: "image/jpg"
    )
  end
end
