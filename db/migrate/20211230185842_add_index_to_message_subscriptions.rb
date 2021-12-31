class AddIndexToMessageSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_index :message_subscriptions, :phone_number
    add_index :message_subscriptions, :ripple_uuid
  end
end
