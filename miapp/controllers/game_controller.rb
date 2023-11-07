class GameController < Sinatra::Application
  set :public_folder, File.expand_path('../views', __dir__)


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

  # Ruta para mostrar el progreso del usuario con la carta seleccionada
  get '/progress' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      @progress = @user.progress
      create_user(user_id) if @progress.nil?
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
end
