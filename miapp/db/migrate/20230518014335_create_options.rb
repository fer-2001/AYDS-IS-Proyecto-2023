# frozen_string_literal: true

# Migration of CreateOptions
class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      t.belongs_to :question, unique: false
      t.string  :content
      t.boolean :correct
      t.timestamps
    end
  end
end
