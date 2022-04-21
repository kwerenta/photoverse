class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_one_attached :photo do |photo|
    photo.variant :avatar, resize_to_fit: [32, 32]
    photo.variant :thumb, resize_to_fit: [100, 100]
  end

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
end
