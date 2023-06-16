require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'rack/session/cookie'

require 'sinatra/reloader' if Sinatra::Base.environment == :development

require_relative 'models/user'
require_relative 'models/report'
require_relative 'models/question'
require_relative 'models/progress'
require_relative 'models/suggestion'
require_relative 'models/option'
require_relative 'models/response'

class App < Sinatra::Application
  def initialize(_app = nil)
    super()
  end

  use Rack::Session::Cookie,
      key: 'my_app_session',
      secret: 'my_app_secret_key',
      expire_after: nil # Sesión persistente

  enable :sessions
  register Sinatra::Flash

  set :root,  File.dirname('miapp')
  set :views, proc { File.join(root, 'views') }
  set :public_folder, File.dirname(__FILE__) + '/views'
  configure :production, :development do
    enable :logging

    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG if development?
    set :logger, logger
  end

  configure :development do
    register Sinatra::Reloader
    after_reload do
      puts 'Reloaded...'
    end
  end

  before do
    # Verifica si el usuario ha iniciado sesión antes de permitir el acceso a todas las rutas excepto /login
    unless ['/', '/register', '/users', '/noRegistrado'].include?(request.path_info) || session[:user_id]
      redirect '/' # Redirige al formulario de inicio de sesión si el usuario no ha iniciado sesión
    end
  end

  get '/' do
    # Si el usuario ya ha iniciado sesión, redirige a la página de inicio
    redirect '/menu' if session[:user_id]
    erb :index
  end

  get '/users' do
    erb :users
  end

  get '/reports' do
    @reports = Report.all
    erb :reports
  end

  get '/register' do
    erb :register
  end

  post '/reports' do
    user_id = session[:user_id]
    @report = Report.find_or_create_by(user_id: params[:user_id],description: params[:description],
                                       date: params[:date])
    erb :reports
  end

  get '/suggestion' do
    erb :suggestion
  end


  get '/progress' do
    erb :progress
  end


  post '/suggestion' do
    user_id = session[:user_id]
    @suggestion = Suggestion.find_or_create_by( user_id: params[:user_id],description: params[:description],
                                              date: params[:date])
    erb :suggestion
  end

  post '/users' do
    username = params[:username]
    password = params[:password]

    # Verifica las credenciales del usuario en tu lógica de autenticación
    user = User.find_by(name: username, pass: password)

    if user
      # Credenciales válidas, establece la sesión
      session[:user_id] = user.id
      session[:username] = user.name

      redirect '/menu' # Redirige a la página de inicio después del inicio de sesión exitoso
    else
      # Credenciales inválidas, muestra un mensaje de error
      flash[:error] = 'Nombre de usuario o contraseña incorrectos'
      redirect '/noRegistrado' # Redirige de nuevo al formulario de inicio de sesión
    end
  end

  get '/noRegistrado' do
    erb :noRegistrado
  end

  post '/logout' do
    session.clear
    redirect '/'
  end

  get '/progress' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      @progress = @user.progress
      erb :progress
    else
      redirect '/users' # Redirigir a la página de inicio de sesión si no hay sesión iniciada
    end
  end

  post '/register' do
    @users = User.find_or_create_by(name: params[:name], pass: params[:pass])
    erb :users
  end

  get '/menu' do
    erb :menu
  end

  get '/questions' do
    @questions = Question.all
    erb :question
  end

  get '/end_game' do
    erb :end_game
  end

  post '/save_question_index' do
    session[:current_question] = params[:question_index].to_i
    status 200
  end

  post '/responses' do
    request_body = JSON.parse(request.body.read)

    option_id = request_body['option_id']
    user_id = request_body['user_id']

    # Verificar si la opción y el usuario existen
    option = Option.find(option_id)
    user = User.find_by(id: user_id)
    unless option && user
      status 404
      return 'Opción o usuario no encontrados'
    end

    # Verificar si el usuario ya ha respondido esa pregunta
    response = Response.find_by(user_id: user_id, option_id: option_id)
    if response
      new_question = Question.where.not(id: @questions.map(&:id)).sample
      # Serializar la nueva pregunta y enviarla como respuesta al cliente
      content_type :json
      { question: new_question }.to_json
      # Obtener la pregunta y la respuesta seleccionada
      question = option.question
      selected_option = Option.find_by(id: option_id)

      # Obtener la respuesta correcta
      correct_option = question.options.find_by(correct: true)

      # Obtener las curiosidades de la pregunta
      curiosities = question.curiosities

      # Renderizar el erb con la curiosidad y la respuesta
      erb :curiosities, locals: { question: question, selected_option: selected_option, correct_option: correct_option, curiosities: curiosities }

    else
      # Crear la respuesta y asociarla al usuario y la opción
      is_correct = option.correct
      Response.create(user_id: user_id, option_id: option_id)


      progress = Progress.find_by(user_id: user_id)
      if progress.nil?
        # Si no se encontró ningún progreso para el usuario, puedes crear uno nuevo
        progress = Progress.create(user_id: user_id)
      end
       # Obtener el progreso del usuario
      if progress
        question = option.question
        if is_correct
          progress.correct_answers += 1
          progress.points += question.cantPoints
          user.points += question.cantPoints
          user.streak += 1
        else
          progress.incorrect_answers += 1
          progress.lose_points += question.cantPoints
          user.lifes -= 1 
          user.streak = 0 
        end

        progress.current_question += 1
        user.save!
        progress.save!
      end

      if is_correct
        '¡Respuesta correcta!'
      else
        'Respuesta incorrecta'
      end
    end


  end
end
