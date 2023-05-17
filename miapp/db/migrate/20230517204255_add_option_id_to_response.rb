class AddOptionIdToResponse < ActiveRecord::Migration[7.0]
  def change
    add_column :responses, :option_id, :integer
    add_index :responses, :option_id, unique: true
  end
end
