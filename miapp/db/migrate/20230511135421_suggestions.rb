class Suggestions < ActiveRecord::Migration[7.0]
  def change
    create_table :suggestions do |t|
      t.string :description
      t.date :date
      t.timestamps
    end
  end
end