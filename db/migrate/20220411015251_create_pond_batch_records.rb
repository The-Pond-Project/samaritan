class CreatePondBatchRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :pond_batch_records do |t|
      t.reference :release, null: false
      t.integer :amount, null: false
      t.string :key, index: true, null: false
      t.string :slug, index: true
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
