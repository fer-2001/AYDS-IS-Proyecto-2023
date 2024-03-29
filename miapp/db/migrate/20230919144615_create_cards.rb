# frozen_string_literal: true

# Migration of CreateCars
class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :position
      t.integer :price, default: 10
      t.boolean :available, default: true
      t.integer :user_id
      t.timestamps
    end
  end
end
