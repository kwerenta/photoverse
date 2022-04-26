class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: :likes_count

  validates :user, presence: true, uniqueness: {scope: :post}
  validates :post, presence: true
end
