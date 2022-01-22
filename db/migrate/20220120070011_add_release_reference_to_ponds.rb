class AddReleaseReferenceToPonds < ActiveRecord::Migration[6.1]
  def change
    add_column :ponds, :release_id, :integer
  end
end
