require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'

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

  get '/game' do
    logger.info 'USANDO LOGGER INFO EN GAME PATH'
    'Game'
  end

  get '/' do
    erb :index
  end

  get '/users' do
    @users = User.all
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
    @report = Report.find_or_create_by( descripcion: params[:descripcion],ide: params[:ide], 
                                         fecha: params[:fecha] )
    erb :reports
  end

  post '/users' do
    @users = User.find(name: params[:name],pass: params[:pass])
    erb :users
  end

  post '/register' do
    @users = User.find_or_create_by(name: params[:name],pass: params[:pass])
    erb :users
  end

  get '/menu' do
    erb :menu
  end

  
  get '/question' do
    erb :question
  end
end

