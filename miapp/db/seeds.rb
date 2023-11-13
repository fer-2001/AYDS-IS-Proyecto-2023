# frozen_string_literal: true

# Método para generar preguntas y opciones asociadas
require_relative '../models/card'

def generate_question(content, options, difficulty, points, curiosity)
  question = Question.create(question: content, difficult: difficulty, cantPoints: points, curiosities: curiosity)
  question.options.create(options)
end

def generate_card(name, position, price, available)
  Card.create(name:, position:, price:, available:)
end

Card.destroy_all
Question.destroy_all

# Generar preguntas sobre la selección argentina en el Mundial 2022
generate_question('¿Cuántos goles marcó Lionel Messi durante el Mundial 2022?', [
                    { content: '4', correct: false },
                    { content: '7', correct: true },
                    { content: '5', correct: false },
                    { content: '3', correct: false }
                    # {Messi metio 7 goles en el mundial 2022, salio 2do mayor goleador del mundial}
                  ], 3, 15, 'Messi salio 2do mayor goleador del mundial 2022 jugado en Qatar')

generate_question('¿Cuál fue el resultado del partido de Argentina contra Francia en la final del mundial 2022?', [
                    { content: 'Empate 3-3', correct: true },
                    { content: 'Victoria de Argentina 2-1', correct: false },
                    { content: 'Empate 2-2', correct: false },
                    { content: 'Derrota de Argentina 1-3', correct: false }
                    # {El Argentina- Francia en octavos resulto en la victoria de argentina 2-1, }
                  ], 2, 15, 'Luego de esto Argentina se consagro CAMPEON MUNDIAL ganandole 4-2 a Francia en penales.')

generate_question('¿Quien fue el DT de la seleccion durante el mundial 2022?', [
                    { content: 'Maradona', correct: false },
                    { content: 'Sampaoli', correct: false },
                    { content: 'Mascherano', correct: false },
                    { content: 'Scaloni', correct: true }
                  ], 4, 15, 'Scaloni fue el DT mas joven del mundial 2022 con 44 años de edad')

generate_question('¿Cual es la mayor Racha de invicto que tuvo la escaloneta?', [
                    { content: '29', correct: false },
                    { content: '27', correct: false },
                    { content: '28', correct: false },
                    { content: '36', correct: true }
                  ], 5, 15, 'La mayor racha fue de 36 partidos.
                   El único partido que perdió Argentina fue contra Arabia Saudita')

generate_question('¿Que fecha la Scaloneta gano la Copa America?', [
                    { content: '10/10/2021', correct: false },
                    { content: '10/6/2021', correct: false },
                    { content: '10/7/2021', correct: true },
                    { content: '10/8/2021', correct: false }
                  ], 6, 15, 'Argentina volvió a ganar la Copa América después de 28 años, tras derrotar a Brasil')

generate_question('¿Despues de cuantos años Argentina gano nuevamente el mundial?', [
                    { content: '15', correct: false },
                    { content: '20', correct: false },
                    { content: '36', correct: true },
                    { content: '29', correct: false }
                  ], 7, 15, 'El ultimo mundial ganado habia sido en 1986 (Mexico) , con Carlos Billardo como DT')

generate_question('¿Cuantos goles hizo Argentina en la Copa America?', [
                    { content: '15', correct: false },
                    { content: '12', correct: true },
                    { content: '25', correct: false },
                    { content: '18', correct: false }
                  ], 8, 15, 'Esta fue la cuadragésima tercera participación de Argentina')

generate_question('¿Quien marco el gol ganador en la final Copa America?', [
                    { content: 'Lionel Messi', correct: false },
                    { content: 'Angel Di Maria', correct: true },
                    { content: 'Julian Alvarez', correct: false },
                    { content: 'Emiliano Martinez', correct: false }
                  ], 9, 15, 'Messi tambien fue el maximo goleador de dicho campeonato con un total de 7 goles')

generate_question('¿Cuantos años tenia Scaloni durante el mundial 2022?', [
                    { content: '44', correct: true },
                    { content: '46', correct: false },
                    { content: '43', correct: false },
                    { content: '37', correct: false }
                  ], 10, 15, 'De los 32 entrenadores que dirigen en el Mundial, Scaloni es el menor a sus
                  44 años por lo cual es el director técnico más joven de la Copa del Mundo 2022')

generate_question('¿Donde se jugo el mundial 2022?', [
                    { content: 'Brasil', correct: false },
                    { content: 'Francia', correct: false },
                    { content: 'Qatar', correct: true },
                    { content: 'Mexico', correct: false }
                  ], 11, 15, 'Tuvo un diseño modular e incorporó 974 contenedores de envío reciclados
                  en homenaje a la historia industrial del sitio, el estadio será donado a algún país
                   candidato a ser sede de la copa mundial de 2030')

generate_question('¿En qué estadio se jugó la final del Mundial de Qatar 2022?', [
                    { content: 'Estadio Internacional Khalifa', correct: false },
                    { content: 'Estadio Lusail Iconic Stadium', correct: true },
                    { content: 'Estadio Al Bayt', correct: false },
                    { content: 'Estadio Al Thumama ', correct: false }
                  ], 12, 15, 'El Estadio Lusail Iconic Stadium tiene una capacidad de 80.000 espectadores y es
                   el estadio más grande construido para la Copa del Mundo de 2022.')

generate_question('¿Cuál fue el jugador más joven de la selección argentina en el Mundial de Qatar 2022?', [
                    { content: 'Nahuel Molina', correct: false },
                    { content: 'Julián Álvarez', correct: true },
                    { content: 'Enzo Fernandez', correct: false },
                    { content: 'Alexis Mac Allister', correct: false }
                  ], 13, 15, 'Julián Álvarez, delantero del Manchester City, fue el jugador más joven de
                   la selección argentina en el Mundial de Qatar 2022. Tenía 19 años cuando debutó en el torneo.')

generate_question('¿Cuál fue el jugador que recibio mas Amarillas?', [
                    { content: 'Leandro Paredes', correct: true },
                    { content: 'Nicolás Otamendi', correct: false },
                    { content: 'Rodrigo De Paul', correct: false },
                    { content: 'Lionel Messi', correct: false }
                  ], 14, 15, 'Leandro Paredes, centrocampista del Paris Saint-Germain, recibió más tarjetas amarillas
                  que ningún otro jugador de la selección argentina. Recibió 4 tarjetas amarillas en 7 partidos.')

generate_question('¿Cuál fue el jugador de la Scaloneta que más asistencias dio en el Mundial de Qatar 2022?', [
                    { content: 'Lautaro Martínez', correct: false },
                    { content: 'Ángel Di María', correct: false },
                    { content: 'Rodrigo De Paul', correct: true },
                    { content: 'Lionel Messi', correct: false }
                  ], 15, 15, 'Rodrigo De Paul, fue el jugador de la Scaloneta que más asistencias
                  dio en el Mundial de Qatar 2022. De Paul dio 8 asistencias en 7
                  partidos, lo que ayudó a la selección argentina a ganar el título.')

generate_question('¿Cuál fue el resultado de Argentina-Croacia?', [
                    { content: 'ARG 3-0 CRO', correct: true },
                    { content: 'ARG 2-0 CRO', correct: false },
                    { content: 'ARG 1-2 CRO', correct: false },
                    { content: 'ARG 2-1 CRO', correct: false }
                  ], 16, 15, 'En el 2018 Croacia le ganó a la Selección Argentina en
                  fase de grupo durante el primer partido, con un resultado 3 a 0.
                  Este mundial Fue la revancha y gano Argentina 3-0')

generate_question('¿Cuantos goles recibio Argentina en el mundial 2022?', [
                    { content: '10', correct: false },
                    { content: '6', correct: false },
                    { content: '8', correct: true },
                    { content: '5', correct: false }
                  ], 17, 15, 'De los 8 goles que le hicieron a Argentina, 6 fueron marcados en los
                  últimos 12 minutos de partido.')

generate_question('¿Cuantas personas recibieron a la Scaloneta al regresar?', [
                    { content: '3 Millones', correct: false },
                    { content: '5 Millones', correct: false },
                    { content: '2 Millones', correct: false },
                    { content: '4 Millones', correct: true }
                  ], 18, 15, 'La selección argentina llegó a Buenos Aires el 22 de diciembre y fue recibida por una
                  multitud eufórica. Los jugadores desfilaron por la plaza en un autobús descapotable,
                  saludando a los aficionados y celebrando su victoria.')

generate_card('Messi', '10', 10, true)
generate_card('Dibala', '21', 10, true)
generate_card('Romero', '13', 10, true)
generate_card('Martinez', '23', 10, true)
generate_card('Molina', '26', 10, true)
generate_card('Otamendi', '19', 10, true)
generate_card('Tagliafico', '8', 10, true)
generate_card('Fernandez', '24', 10, true)
generate_card('De Paul', '7', 10, true)
generate_card('Mac Allister', '20', 10, true)
generate_card('Di Maria', '11', 10, true)
generate_card('Alvarez', '9', 10, true)
generate_card('Scaloni', '0', 10, true)
