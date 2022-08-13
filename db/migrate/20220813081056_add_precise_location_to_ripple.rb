class AddPreciseLocationToRipple < ActiveRecord::Migration[7.0]
  def change
    add_column :ripples, :precise_location, :boolean, default: false
  end
end
