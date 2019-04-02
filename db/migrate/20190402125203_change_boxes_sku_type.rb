class ChangeBoxesSkuType < ActiveRecord::Migration[5.2]
  def change
      change_column :boxes, :box_sku, :string
  end
end
