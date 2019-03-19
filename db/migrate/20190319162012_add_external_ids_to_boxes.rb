class AddExternalIdsToBoxes < ActiveRecord::Migration[5.2]
  def change
    add_column :boxes, :external_ids, :string
  end
end
