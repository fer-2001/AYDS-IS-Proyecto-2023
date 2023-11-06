# frozen_string_literal: true

require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'rack/session/cookie'

require 'sinatra/reloader' if Sinatra::Base.environment == :development
require './controllers/user_controller'
require './controllers/game_controller'
require './controllers/store_controller'
require './controllers/others_controller'

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
  use GameController
  use StoreController
  use OthersController

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
end
