class CreateProgress < ActiveRecord::Migration[7.0]
  def change
    create_table :progress do |t|
      t.integer :totalRespuestaCorrecta
      t.integer :totalRespuestaIncorrecta
      t.integer :puntosPerdidos
      t.integer :puntosTotales
      t.timestamps
    end
  end
end
