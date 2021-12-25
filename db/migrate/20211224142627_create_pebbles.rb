class CreatePebbles < ActiveRecord::Migration[6.1]
  def change
    create_table :pebbles do |t|
      t.string :pebble_key
      t.string :uuid
      t.string :postal_code
      t.string :city
      t.string :region
      t.string :country

      t.timestamps
    end
  end
end
