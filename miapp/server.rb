require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'

require 'sinatra/reloader' if Sinatra::Base.environment == :development


require_relative 'models/user'
require_relative 'models/report'
require_relative 'models/question'


class App < Sinatra::Application
  def initialize(app = nil)
    super()
  end

  set :root,  File.dirname('miapp')
  set :views, Proc.new { File.join(root, 'views') }

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

  post '/users' do
    @users = User.find_or_create_by(name: params[:name],pass: params[:pass])
    erb :users
  end
end

