class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true, counter_cache: :likes_count

  validates :user_id, presence: true, uniqueness: {scope: %i[likeable_id likeable_type]}
end
