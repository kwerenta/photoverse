class AddFollowersCountToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :followers_count, :integer, null: false, default: 0
    add_column :users, :followings_count, :integer, null: false, default: 0
  end
end
