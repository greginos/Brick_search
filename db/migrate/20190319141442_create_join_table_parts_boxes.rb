class CreateJoinTablePartsBoxes < ActiveRecord::Migration[5.2]
  def change
    create_join_table :parts, :boxes do |t|
      # t.index [:part_id, :box_id]
      # t.index [:box_id, :part_id]
    end
  end
end
