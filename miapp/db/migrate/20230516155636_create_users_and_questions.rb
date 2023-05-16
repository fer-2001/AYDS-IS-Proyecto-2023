class CreateUsersAndQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :users_questions, id: false do |t|
      t.belongs_to :user
      t.belongs_to :question
    end
  end
end
