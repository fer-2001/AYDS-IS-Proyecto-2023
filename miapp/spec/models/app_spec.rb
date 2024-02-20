# frozen_string_literal: true

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
    it 'should redirect to /users if user is not logged in' do
      get '/progress'
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path_info).to eq('/')
    end
  end

  describe 'User registration' do
    context 'with valid parameters' do
      # A new user is created in each execution to avoid having to manipulate the data in the database
      timestamp = Time.now.to_s
      let(:user_name) { 'Test' + timestamp }
      it 'should register the user and redirect to /users' do
        post '/register', name: user_name, pass: 'L1'
        follow_redirect!
        expect(last_request.path_info).to eq('/users')
      end
    end

    context 'with invalid parameters' do
      it 'should show an error message and stay on the /register page' do
        post '/register', name: 'Juan', pass: 'J'
        expect(last_response).not_to be_redirect
      end
    end
  end
end
