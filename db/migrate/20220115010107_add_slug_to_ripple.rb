class AddSlugToRipple < ActiveRecord::Migration[6.1]
  def change
    add_column :ripples, :slug, :string
    add_index :ripples, :slug, unique: true
  end
end
