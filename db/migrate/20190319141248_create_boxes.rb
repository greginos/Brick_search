class CreateBoxes < ActiveRecord::Migration[5.2]
  def change
    create_table :boxes do |t|
      t.integer :box_sku
      t.string :name

      t.timestamps
    end
  end
end
