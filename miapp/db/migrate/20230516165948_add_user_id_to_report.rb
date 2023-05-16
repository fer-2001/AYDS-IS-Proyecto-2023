class AddUserIdToReport < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :user_id, :integer
    add_index :reports, :user_id, unique: true
  end
end
