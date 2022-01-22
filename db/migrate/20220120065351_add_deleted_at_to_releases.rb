class AddDeletedAtToReleases < ActiveRecord::Migration[6.1]
  def change
    add_column :releases, :deleted_at, :datetime
    add_index :releases, :deleted_at
  end
end
