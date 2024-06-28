class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: :comments_count
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy, inverse_of: :parent

  validates :content, presence: true
end
