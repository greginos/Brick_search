class ChangePartsSkuType < ActiveRecord::Migration[5.2]
  def change
    change_column :parts, :part_sku, :string
  end
end
