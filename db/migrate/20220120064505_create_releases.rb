class CreateReleases < ActiveRecord::Migration[6.1]
  def change
    create_table :releases do |t|
      t.string :name
      t.text :description
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
