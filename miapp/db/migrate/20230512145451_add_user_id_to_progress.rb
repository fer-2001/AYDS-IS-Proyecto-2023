class AddUserIdToProgress < ActiveRecord::Migration[7.0]
  def change
    add_column :progress, :user_id, :integer
    add_index :progress, :user_id, unique: true
  end
end
