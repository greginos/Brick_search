class CreateJoinTablePartsBoxes < ActiveRecord::Migration[5.2]
  def change
    create_join_table :parts, :boxes do |t|
      t.index :part_id
      t.index :box_id
    end
  end
end
