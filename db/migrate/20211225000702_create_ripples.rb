class CreateRipples < ActiveRecord::Migration[6.1]
  def change
    create_table :ripples do |t|
      t.string :uuid, index: { unique: true }
      t.string :postal_code
      t.string :city
      t.string :country
      t.string :region
      t.references :user, null: true, foreign_key: true
      t.references :pond, null: false, foreign_key: true

      t.timestamps
    end
  end
end
