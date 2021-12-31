class CreateStories < ActiveRecord::Migration[6.1]
  def change
    create_table :stories do |t|
      t.string :title
      t.text :body,    null: false
      t.string :pond_key
      t.string :ripple_uuid

      t.timestamps
    end
  end
end
