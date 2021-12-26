class AddDeletedAtToPonds < ActiveRecord::Migration[6.1]
  def change
    add_column :ponds, :deleted_at, :datetime
    add_index :ponds, :deleted_at
  end
end
