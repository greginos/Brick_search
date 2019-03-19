class CreateColors < ActiveRecord::Migration[5.2]
  def change
    create_table :colors do |t|
      t.string :rgb
      t.string :name
      t.boolean :is_trans
      t.string :external_ids

      t.timestamps
    end
  end
end
