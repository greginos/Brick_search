class AddExternalIdsToParts < ActiveRecord::Migration[5.2]
  def change
    add_column :parts, :external_ids, :string
  end
end
