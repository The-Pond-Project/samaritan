class AddVpnToRipples < ActiveRecord::Migration[7.0]
  def change
    add_column :ripples, :vpn, :boolean, default: false
  end
end
