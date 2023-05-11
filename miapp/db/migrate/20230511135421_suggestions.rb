class Suggestions < ActiveRecord::Migration[7.0]
  def change
    create_table :suggestions do |t|
      t.integer :codigo_sugerencia
      t.string :descripcion
      t.date :fecha
    end
  end
end
