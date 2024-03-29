# frozen_string_literal: true

# Migration of CreateReports
class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.belongs_to :user, unique: false
      t.string :description
      t.date :date
      t.timestamps
    end
  end
end
