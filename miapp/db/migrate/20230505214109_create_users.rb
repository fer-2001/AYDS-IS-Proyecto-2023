class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.integer :lifes , default: 5
      t.integer :points, default: 0
      t.integer :streak, default: 0
      t.integer :coins, default: 0
      t.string :card, default: 'card'
      t.string :role, default: 'clasificado'
      t.string :password_digest
      t.timestamps
    end
  end
end
