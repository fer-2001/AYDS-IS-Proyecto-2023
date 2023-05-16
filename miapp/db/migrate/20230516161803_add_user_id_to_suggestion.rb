class AddUserIdToSuggestion < ActiveRecord::Migration[7.0]
  def change
    add_column :suggestion, :user_id, :integer
    add_index :suggestion, :user_id, unique: true
  end
end
