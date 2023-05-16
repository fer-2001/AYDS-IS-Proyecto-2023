class AddUserIdToSuggestion < ActiveRecord::Migration[7.0]
  def change
    add_column :suggestions, :user_id, :integer
    add_index :suggestions, :user_id, unique: true
  end
end
