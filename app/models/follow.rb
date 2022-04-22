class Follow < ApplicationRecord
  belongs_to :follower, foreign_key: :follower_id, class_name: "User", counter_cache: :followings_count
  belongs_to :following, foreign_key: :following_id, class_name: "User", counter_cache: :followers_count

  validates :follower_id, presence: true, uniqueness: {scope: :following_id}
  validates :following_id, presence: true, comparison: {other_than: :follower_id}
end
