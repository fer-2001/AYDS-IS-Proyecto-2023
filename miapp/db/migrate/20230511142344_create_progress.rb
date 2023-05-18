class CreateProgress < ActiveRecord::Migration[7.0]
  def change
    create_table :progress do |t|
      t.belongs_to :user
      t.integer :correctAnswers
      t.integer :incorrectAnswers
      t.integer :losePoints
      t.integer :points
      t.timestamps
    end
  end
end
