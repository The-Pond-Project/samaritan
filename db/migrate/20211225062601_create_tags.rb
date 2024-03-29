class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.text :description
      t.string :organization
      t.boolean :approved

      t.timestamps
    end
  end
end
