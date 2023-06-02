# Método para generar preguntas y opciones asociadas
def generate_question(content, options, difficulty, points)
  question = Question.create(question: content, difficult: difficulty, cantPoints: points)
  question.options.create(options)
end

Question.destroy_all

# Generar preguntas sobre la selección argentina en el Mundial 2022
generate_question('¿Cuántos goles marcó Lionel Messi durante el Mundial 2022?', [
                    { content: '4', correct: false },
                    { content: '2', correct: true },
                    { content: '5', correct: false },
                    { content: '3', correct: false }
                  ], 3, 10)

generate_question('¿Cuál fue el resultado del partido de Argentina contra Francia en los octavos de final?', [
                    { content: 'Empate 1-1', correct: false },
                    { content: 'Victoria de Argentina 2-1', correct: true },
                    { content: 'Derrota de Argentina 0-2', correct: false },
                    { content: 'Derrota de Argentina 1-3', correct: false }
                  ], 2, 15)
