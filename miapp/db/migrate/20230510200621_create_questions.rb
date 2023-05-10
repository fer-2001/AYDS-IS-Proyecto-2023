class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :pregunta
      t.integer :identificador
      t.integer :dificultad
      t.integer :cantPuntos
    end
  end
end

