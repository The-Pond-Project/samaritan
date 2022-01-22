class RemoveOrganizationColumnFromTags < ActiveRecord::Migration[6.1]
  def change
    remove_column :tags, :organization
  end
end
