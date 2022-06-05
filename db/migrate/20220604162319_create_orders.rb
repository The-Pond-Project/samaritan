class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :amount, null: false
      t.string :email
      t.string :address1, null: false
      t.string :address2
      t.string :city, null: false
      t.string :postal_code, null: false
      t.string :region, null: false
      t.string :country, null: false
      t.string :phone
      t.string :uuid, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.boolean :shipped, null: false, default: false

      t.timestamps

      t.index :uuid, unique: true
    end
  end
end
