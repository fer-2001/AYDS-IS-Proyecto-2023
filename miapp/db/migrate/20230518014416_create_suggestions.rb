# frozen_string_literal: true

# Migration of CreateSuggestions
class CreateSuggestions < ActiveRecord::Migration[7.0]
  def change
    create_table :suggestions do |t|
      t.belongs_to :user, unique: false
      t.string :description
      t.date :date
      t.timestamps
    end
  end
end
