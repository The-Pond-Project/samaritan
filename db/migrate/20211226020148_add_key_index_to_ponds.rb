class AddKeyIndexToPonds < ActiveRecord::Migration[6.1]
  def change
    add_index :ponds, :key, unique: true
  end
end
