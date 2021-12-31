class CreateMessageSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :message_subscriptions do |t|
      t.string :phone_number,    null: false
      t.string :ripple_uuid,     null: false

      t.timestamps
    end
  end
end
