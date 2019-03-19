class CreateParts < ActiveRecord::Migration[5.2]
  def change
    create_table :parts do |t|
      t.integer :part_sku
      t.string :color

      t.timestamps
    end
  end
end
