class AddPassToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :pass, :string
  end
end
