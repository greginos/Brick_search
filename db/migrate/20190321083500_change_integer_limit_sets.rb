class ChangeIntegerLimitSets < ActiveRecord::Migration[5.2]
  def change
    change_column :boxes, :box_sku, :integer, limit: 8
  end
end
