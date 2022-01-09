class AddCoordinatesToRipples < ActiveRecord::Migration[6.1]
  def change
    add_column :ripples, :latitude, :float
    add_column :ripples, :longitude, :float
  end
end
