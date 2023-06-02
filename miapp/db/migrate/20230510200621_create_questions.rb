class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :question
      t.integer :difficult
      t.integer :cantPoints
      t.string :curiosities
      t.timestamps
    end
  end
end
