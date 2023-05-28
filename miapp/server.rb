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
  def initialize(app = nil)
    super()
  end

  use Rack::Session::Cookie,
    key: 'my_app_session',
    secret: 'my_app_secret_key',
    expire_after: nil # Sesión persistente

  enable :sessions
  register Sinatra::Flash


  set :root,  File.dirname('miapp')
  set :views, Proc.new { File.join(root, 'views') }
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
    unless ['/','/register','/users','/noRegistrado'].include?(request.path_info) || session[:user_id]
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
    @report = Report.find_or_create_by(user_id: params[:user_id], description: params[:description],
                                         date: params[:date] )
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


  post '/register' do
    @users = User.find_or_create_by(name: params[:name],pass: params[:pass])
    erb :users
  end

  get '/menu' do
    erb :menu
  end

  get '/questions' do
    @questions = Question.includes(:options)
    erb :question
  end

  post '/questions' do
    user_id = session[:user_id]
    option_id = params[:option_id]
  
    if user_id && option_id
      response = Response.create(user_id: user_id, option_id: option_id)
      # Aquí puedes realizar otras acciones relacionadas con la respuesta
  
      redirect '/questions' # Redirige nuevamente a la página de preguntas
    else
      flash[:error] = 'Opción inválida. Por favor, selecciona una opción antes de continuar.'
      redirect '/questions' # Redirige nuevamente a la página de preguntas
    end
  end
  
  
  
end
