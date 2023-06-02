# Método para generar preguntas y opciones asociadas
def generate_question(content, options, difficulty, points, curiosity)
  question = Question.create(question: content, difficult: difficulty, cantPoints: points, curiosities: curiosity)
  question.options.create(options)
end

Question.destroy_all

# Generar preguntas sobre la selección argentina en el Mundial 2022
generate_question('¿Cuántos goles marcó Lionel Messi durante el Mundial 2022?', [
                    { content: '4', correct: false },
                    { content: '7', correct: true },
                    { content: '5', correct: false },
                    { content: '3', correct: false },
                    #{Messi metio 7 goles en el mundial 2022, salio 2do mayor goleador del mundial}
                  ], 3, 10, 'Messi metio 7 goles en el mundial 2022, salio 2do mayor goleador del mundial')

generate_question('¿Cuál fue el resultado del partido de Argentina contra Francia en los octavos de final?', [
                    { content: 'Empate 1-1', correct: false },
                    { content: 'Victoria de Argentina 2-1', correct: true },
                    { content: 'Derrota de Argentina 0-2', correct: false },
                    { content: 'Derrota de Argentina 1-3', correct: false }
                    #{El Argentina- Francia en octavos resulto en la victoria de argentina 2-1, }
                  ], 2, 15, 'El Argentina- Francia en octavos resulto en la victoria de argentina 2-1')

generate_question('¿Quien fue el DT de la seleccion durante el mundial 2022?', [
                    { content: 'Maradona', correct: false },
                    { content: 'Sampaoli', correct: false },
                    { content: 'Mascherano', correct: false },
                    { content: 'Scaloni', correct: true }
                  ], 4, 15, 'COMPLETAR')
 
generate_question('¿Cual es la mayor Racha de invicto que tuvo la escaloneta?', [
                    { content: '29', correct: false },
                    { content: '27', correct: false },
                    { content: '28', correct: false },
                    { content: '30', correct: true }
                  ], 5, 15, 'COMPLETAR')

generate_question('¿Que fecha la Scaloneta gano la copa America?', [
                    { content: '10/10/021', correct: false },
                    { content: '10/6/021', correct: false },
                    { content: '10/7/021', correct: false },
                    { content: '10/8/021', correct: true }
                  ], 6, 15, 'COMPLETAR')

generate_question('¿Despues de cuantos años Argentina gano nuevamente el mundial?', [
                    { content: '15', correct: false },
                    { content: '20', correct: false },
                    { content: '28', correct: false },
                    { content: '29', correct: true }
                  ], 7, 15, 'COMPLETAR')

generate_question('¿Despues de cuantos años Argentina gano nuevamente el mundial?', [
                    { content: '15', correct: false },
                    { content: '20', correct: false },
                    { content: '28', correct: false },
                    { content: '29', correct: true }
                  ], 8, 15, 'COMPLETAR')
                  
              
