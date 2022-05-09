class CreatePondBatchRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :pond_batch_records do |t|
      t.references :release, null: false
      t.integer :amount, null: false
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
