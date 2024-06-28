class AddUniqueIndexToFollow < ActiveRecord::Migration[7.0]
  def change
    add_index :follows, %i[following_id follower_id], unique: true
  end
end
