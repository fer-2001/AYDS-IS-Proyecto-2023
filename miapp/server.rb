# frozen_string_literal: true

require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'rack/session/cookie'

require 'sinatra/reloader' if Sinatra::Base.environment == :development
require './controllers/user_controller'

require_relative 'models/user'
require_relative 'models/report'
require_relative 'models/question'
require_relative 'models/progress'
require_relative 'models/suggestion'
require_relative 'models/option'
require_relative 'models/response'
require_relative 'models/card'


class App < Sinatra::Application
  use UserController

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
  set :public_folder, "#{File.dirname(__FILE__)}/views"
  configure :production, :development do
    enable :logging

    logger = Logger.new($stdout)
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
    unless ['/', '/register', '/users', '/noRegistrado',
            '/increment_lifes'].include?(request.path_info) || session[:user_id]
      redirect '/' # Redirige al formulario de inicio de sesión si el usuario no ha iniciado sesión
    end
  end

  get '/' do
    # Si el usuario ya ha iniciado sesión, redirige a la página de inicio
    redirect '/menu' if session[:user_id]
    erb :index
  end


  get '/reports' do
    @reports = Report.all
    erb :reports
  end


  post '/reports' do
    session[:user_id]
    @report = Report.find_or_create_by(user_id: params[:user_id], description: params[:description],
                                       date: params[:date])
    erb :reports
  end

  get '/suggestion' do
    erb :suggestion
  end


  post '/suggestion' do
    session[:user_id]
    @suggestion = Suggestion.find_or_create_by(user_id: params[:user_id], description: params[:description],
                                               date: params[:date])
    erb :suggestion
  end


  # Ruta para mostrar el progreso del usuario con la carta seleccionada
  get '/progress' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      @progress = @user.progress
      if @progress.nil?
        create_user(user_id)
      end
      @selected_card_id = params[:card_id]

      erb :progress
    else
      redirect '/users' 
    end
  end





  get '/menu' do
    @user = User.find(session[:user_id])
    erb :menu
  end

  get '/questions' do
    @user = User.find(session[:user_id])
    @progress = @user.progress
    if @user.check_lifes
      erb :lifes
    else
      @questions = Question.all
      erb :question
    end
  end

  get '/end_game' do
    erb :end_game
  end

  get '/check_lifes' do
    if session[:user_id]
      user = User.find(session[:user_id])
      content_type :json
      { lifes: user.lifes }.to_json
    else
      status 401 # No se ha iniciado sesión
    end
  end

  get '/lifes' do
    erb :lifes
  end


  post '/responses' do
    request_body = JSON.parse(request.body.read)

    status, response_data = Response.handle_response(request_body)

    status status
    content_type :json
    response_data
  end


  get '/leaderboard' do
    @datos = User.order(points: :desc).limit(5)
    erb :leaderboard
  end

  get '/store' do
    @user = User.find(session[:user_id])
    @cards = Card.all

    # Verificamos si se ha enviado un parámetro card_id (por ejemplo, desde un formulario de compra)
    if params[:card_id]
      card = Card.find(params[:card_id])
      if @user.buy_card(card)
        redirect '/menu', notice: '¡Compra exitosa!'
      else
        redirect '/store', error: 'No se pudo comprar la carta.'
      end
    end

    erb :store
  end

  get '/cards' do
    @user = User.find(session[:user_id])
    erb :cards
  end


  # Ruta para comprar una carta
  post '/buy_card/:card_id' do
    @user = User.find(session[:user_id])
    card_number = params[:card_id].to_i # Convertir a número entero
    if @user.buy_card(card_number)
      redirect '/exito'
    else
      redirect '/fail'
    end
  end

  get '/exito' do
    erb :exito
  end

  get '/fail' do
    erb :fail
  end

  # Metodo para asignar nombre de carta en el user
  post '/use_card' do
    card_name = params[:card_name]
    @user = User.find(session[:user_id])

    @user.card = card_name
    # Redirigir a la página de menu
    if @user.save
      @user.set_card_by_name
      @user.save
      # Redirigir a la página de menu si la actualización se guardó correctamente
      redirect '/progress'
    end
  end
end
