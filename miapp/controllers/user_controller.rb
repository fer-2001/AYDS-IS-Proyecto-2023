class UserController < Sinatra::Application
  set :public_folder, File.expand_path('../views', __dir__)


  get '/users' do
    erb :users
  end

  post '/users' do
    username = params[:username]
    password = params[:password]
    user = User.find_by(name: username)
    if user&.authenticate(password)
      session[:user_id] = user.id
      session[:username] = user.name
    else
      flash[:error] = 'Nombre de usuario o contraseña incorrectos'
      redirect '/noRegistrado' # Redirige de nuevo al formulario de inicio de sesión
      return
    end
    @user = User.find(session[:user_id])
    @progress = @user.progress || Progress.create(user_id: @user.id, points: 0, correct_answers: 0,
                                                  incorrect_answers: 0)
    redirect '/menu' # Redirige a la página de inicio después del inicio de sesión exitoso
  end

  get '/noRegistrado' do
    erb :noRegistrado
  end

  post '/logout' do
    session.clear
    redirect '/'
  end


  post '/register' do
    name = params[:name]

    if User.exists?(name:)
      @user_exists = true
      erb :register
    else
      @user = User.new(name:, password: params[:pass])
      if @user.save
        flash[:success] = 'Usuario registrado exitosamente'
        redirect '/users'
      else
        flash[:error] = 'Error al registrar el usuario'
        redirect '/register'
      end
    end
  end

  get '/register' do
    erb :register
  end
end
