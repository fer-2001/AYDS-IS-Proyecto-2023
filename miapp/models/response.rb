# frozen_string_literal: true

# Class Response
class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :option

  def self.handle_response(request_body)
    option_id = request_body['option_id']
    user_id = request_body['user_id']

    # Verificar si la opción y el usuario existen
    option = Option.find(option_id)
    user = User.find_by(id: user_id)
    return [404, 'Opción o usuario no encontrados'] unless option && user

    # Verificar si el usuario ya ha respondido esa pregunta
    response = Response.find_by(user_id:, option_id:)
    if response
      new_question = Question.where.not(id: user.questions.map(&:id)).sample
      content_type :json
      question = option.question
      selected_option = Option.find_by(id: option_id)
      # Obtener la respuesta correcta
      correct_option = question.options.find_by(correct: true)

      # Obtener las curiosidades de la pregunta
      curiosities = question.curiosities

      # Renderizar el erb con la curiosidad y la respuesta
      erb :curiosities, locals: {
        question:,
        selected_option:,
        correct_option:,
        curiosities:
      }
      [200, { question: new_question }.to_json]
    else
      # Crear la respuesta y asociarla al usuario y la opción
      is_correct = option.correct
      Response.create(user:, option:)

      progress = Progress.find_or_create_by(user:)

      progress.update_progress(option, is_correct)
      user.update_fields(option)
      user.update_role

      return [200, '¡Respuesta correcta!'] if is_correct

      [200, 'Respuesta incorrecta']

    end
  end
end
