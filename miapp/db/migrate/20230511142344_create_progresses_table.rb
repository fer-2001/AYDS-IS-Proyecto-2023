# frozen_string_literal: true

# Migration of CreateProgressesTable
class CreateProgressesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :progresses do |t|
      t.belongs_to :user
      t.integer :current_question, default: 0
      t.integer :correct_answers, default: 0
      t.integer :incorrect_answers, default: 0
      t.integer :lose_points, default: 0
      t.integer :points, default: 0
      t.integer :question_index
      # t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
