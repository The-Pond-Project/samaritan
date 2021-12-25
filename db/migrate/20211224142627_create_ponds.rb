class CreatePonds < ActiveRecord::Migration[6.1]
  def change
    create_table :ponds do |t|
      t.string :key
      t.string :uuid
      t.string :postal_code
      t.string :city
      t.string :region
      t.string :country

      t.timestamps
    end
  end
end
