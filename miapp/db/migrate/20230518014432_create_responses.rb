# frozen_string_literal: true

# Migration of CreateResponses
class CreateResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :responses, id: false do |t|
      t.belongs_to :user, unique: false
      t.belongs_to :option
      t.timestamps
    end
  end
end
