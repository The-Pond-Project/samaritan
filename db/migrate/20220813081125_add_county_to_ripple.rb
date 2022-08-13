class AddCountyToRipple < ActiveRecord::Migration[7.0]
  def change
    add_column :ripples, :county, :string
  end
end
