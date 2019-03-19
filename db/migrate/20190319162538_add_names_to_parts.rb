class AddNamesToParts < ActiveRecord::Migration[5.2]
  def change
    add_column :parts, :name, :string
  end
end
