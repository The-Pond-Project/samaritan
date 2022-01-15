class AddUuidToStories < ActiveRecord::Migration[6.1]
  def change
    add_column :stories, :uuid, :string
    add_index :ponds, :uuid, unique: true
  end
end
