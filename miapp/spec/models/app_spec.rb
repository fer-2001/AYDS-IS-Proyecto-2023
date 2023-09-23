require 'rack/test'
require_relative '../../server'

RSpec.describe 'App' do
  include Rack::Test::Methods 

  def app
    App
  end

  describe 'Main routes' do
    it 'should load the home page' do
      get '/'
      expect(last_response).to be_ok
    end

    it 'should load the register page' do
      get '/register'
      expect(last_response).to be_ok
    end

    it 'should redirect to /menu if user is authenticated' do
      # Simula una sesión iniciada
      allow_any_instance_of(App).to receive(:session).and_return({ user_id: 1 })
      
      get '/'
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path_info).to eq('/menu')
    end
  end

  describe 'User authentication' do
    it 'should authenticate the user with valid credentials' do
      # Reemplaza con credenciales de usuario válidas en tu base de datos
      post '/users', username: 'Mario', password: 'M3'
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path_info).to eq('/menu')
    end

    it 'should show an error message with invalid credentials' do
      # Reemplaza con credenciales de usuario inválidas
      post '/users', username: 'nombre_de_usuario_$#"!', password: 'contraseña_incorrecta'
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path_info).to eq('/noRegistrado')
    end

    it 'should log out the user' do
      # Simula una sesión iniciada
      allow_any_instance_of(App).to receive(:session).and_return({ user_id: 1 })
      
      post '/logout'
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path_info).to eq('/')
    end
  end

  describe 'Progress path' do

    it 'should load progress page if user is authenticated' do
      # Simula una sesión iniciada
      allow_any_instance_of(App).to receive(:session).and_return({ user_id: 1 })

      # Reemplaza el valor de card_id con un valor válido según tus datos de prueba
      get '/progress'
      expect(last_response).to be_ok
    end

    it 'should redirect to home page if user is not authenticated' do
      get '/progress', card_id: 1
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path_info).to eq('/')
    end
  end
end 