class AddOrganizationReferenceToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :organization_id, :integer
  end
end
