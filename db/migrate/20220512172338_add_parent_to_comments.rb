class AddParentToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :parent, index: true
  end
end
