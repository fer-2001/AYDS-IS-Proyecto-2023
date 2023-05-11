class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :vidas, :integer
    add_column :users, :puntos, :integer
    add_column :users, :racha, :integer
  end
end
