class AddDeletedAtToRipples < ActiveRecord::Migration[6.1]
  def change
    add_column :ripples, :deleted_at, :datetime
    add_index :ripples, :deleted_at
  end
end
