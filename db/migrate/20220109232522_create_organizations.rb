class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :website
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :organizations, :deleted_at
    add_index :organizations, :name, unique: true
  end
end
