class CreateProgress < ActiveRecord::Migration[7.0]
  def change
    create_table :progress do |t|
      t.belongs_to :user
      t.integer :correctAnswers, default: 0
      t.integer :incorrectAnswers, default: 0
      t.integer :losePoints, default: 0
      t.integer :points, default: 0
      t.string :role
      t.timestamps
    end
  end
end
