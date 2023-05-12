class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :pass
      t.integer :lifes
      t.integer :points
      t.integer :streak
      t.timestamps
    end
  end
end
