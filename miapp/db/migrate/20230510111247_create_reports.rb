class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :descripcion
      t.integer :ide
      t.date :fecha

      t.timestamps
    end
  end
end
