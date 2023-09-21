# Método para generar preguntas y opciones asociadas
require_relative '../models/card'

def generate_question(content, options, difficulty, points, curiosity)
  question = Question.create(question: content, difficult: difficulty, cantPoints: points, curiosities: curiosity)
  question.options.create(options)
end

def generate_card(name, position, price, available)
  card = Card.create(name: name, position: position, price: price, available: available)
end

Card.destroy_all
Question.destroy_all

# Generar preguntas sobre la selección argentina en el Mundial 2022
generate_question('¿Cuántos goles marcó Lionel Messi durante el Mundial 2022?', [
                    { content: '4', correct: false },
                    { content: '7', correct: true },
                    { content: '5', correct: false },
                    { content: '3', correct: false },
                    #{Messi metio 7 goles en el mundial 2022, salio 2do mayor goleador del mundial}
                  ], 3, 15, 'Messi salio 2do mayor goleador del mundial 2022 jugado en Qatar')

generate_question('¿Cuál fue el resultado del partido de Argentina contra Francia en la final del mundial 2022?', [
                    { content: 'Empate 3-3', correct: true },
                    { content: 'Victoria de Argentina 2-1', correct: false },
                    { content: 'Empate 2-2', correct: false },
                    { content: 'Derrota de Argentina 1-3', correct: false }
                    #{El Argentina- Francia en octavos resulto en la victoria de argentina 2-1, }
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
                  ], 5, 15, 'La mayor racha fue de 36 partidos. El único partido que perdió Argentina fue contra Arabia Saudita')

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


generate_card("Messi", "10",10, true)
generate_card("Dibala", "21",10, true)
generate_card("Romero", "13",10, true)
generate_card("Martinez", "23",10, true)
generate_card("Molina", "26",10, true)
generate_card("Otamendi", "19",10, true)
generate_card("Tagliafico", "8",10, true)
generate_card("Fernandez", "24",10, true)
generate_card("De Paul", "7",10, true)
generate_card("Mac Allister", "20",10, true)
generate_card("Di Maria", "11",10, true)
generate_card("Alvarez", "9",10, true)
generate_card("Scaloni", "0",10, true)
