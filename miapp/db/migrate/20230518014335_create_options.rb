class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      t.belongs_to :question, unique: false
      t.string  :content
      t.timestamps
    end
  end
end
