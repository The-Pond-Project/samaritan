class AddSlugToPond < ActiveRecord::Migration[6.1]
  def change
    add_column :ponds, :slug, :string
    add_index :ponds, :slug, unique: true
  end
end
