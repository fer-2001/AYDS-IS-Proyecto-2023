class AddUserIdToResponse < ActiveRecord::Migration[7.0]
  def change
    add_column :responses, :user_id, :integer
    add_index :responses, :user_id, unique: true
  end
end
