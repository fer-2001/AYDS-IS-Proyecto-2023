class CreateLeaderboards < ActiveRecord::Migration[7.0]
  def change
    create_table :leaderboards do |t|
      t.integer :rank
      t.timestamps
    end
  end
end
