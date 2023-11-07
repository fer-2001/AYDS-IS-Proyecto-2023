require 'sinatra/reloader' if Sinatra::Base.environment == :development

class StoreController < Sinatra::Application
  set :public_folder, File.expand_path('../views', __dir__)
  set :views, File.expand_path('../views', __dir__)


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
