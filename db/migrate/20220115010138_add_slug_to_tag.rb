class AddSlugToTag < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :slug, :string
    add_index :tags, :slug, unique: true
  end
end
