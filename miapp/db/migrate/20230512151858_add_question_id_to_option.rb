class AddQuestionIdToOption < ActiveRecord::Migration[7.0]
  def change
    add_column :options, :question_id, :integer
    add_index :options, :question_id, unique: true
  end
end
