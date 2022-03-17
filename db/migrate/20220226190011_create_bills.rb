class CreateBills < ActiveRecord::Migration[6.1]
  def change
    create_table :bills do |t|
      t.string :name, index: true, null: false
      t.text :description, null: false
      t.string :slug, index: true
      t.integer :recurrence
      t.integer :expense_type
      t.float :amount, null: false
      t.boolean :paid, null: false
      t.timestamp :due_at, null: false
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
