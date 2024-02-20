# frozen_string_literal: true

require_relative '../../controllers/store_controller'
require_relative '../../models/user'
require_relative '../../models/card'

describe StoreController do
  include Rack::Test::Methods

  def app
    StoreController
  end

  let(:user) { User.create(name: 'John', password: 'password', lifes: 3, points: 0, streak: 0, role: 'Novato', coins: 20) }
  let(:card) { Card.create(name: 'Messi', position: 1, price: 10, available: true) }

  before do
    allow(User).to receive(:find).with(user.id).and_return(user)
  end

  describe 'GET /store' do
    it 'renders the store page' do
      get '/store'
      expect(last_response).to be_ok
    end
  end

  describe 'GET /store with card_id parameter' do
    context 'when user has enough coins' do
      it 'redirects to menu with a success notice' do
        user.coins = 20
        user.save

        allow(Card).to receive(:find).with('1').and_return(card)

        get '/store', { card_id: '1' }, 'rack.session' => { user_id: user.id }

        expect(last_response).to be_redirect
        follow_redirect!
        expect(last_request.path).to eq('/menu')
      end
    end

    context 'when user does not have enough coins' do
      it 'redirects back to store with an error notice' do
        user.coins = 5
        user.save

        allow(Card).to receive(:find).with('1').and_return(card)

        get '/store', { card_id: '1' }, 'rack.session' => { user_id: user.id }

        expect(last_response).to be_redirect
        follow_redirect!
        expect(last_request.path).to eq('/store')
      end
    end
  end

  describe 'POST /buy_card/:card_id' do
    context 'when user has enough coins' do
      it 'redirects to success page' do
        user.coins = 20
        user.save

        allow(Card).to receive(:find).with('1').and_return(card)

        post "/buy_card/1", {}, 'rack.session' => { user_id: user.id }

        expect(last_response).to be_redirect
        follow_redirect!
        expect(last_request.path).to eq('/exito')
      end
    end

    context 'when user does not have enough coins' do
      it 'redirects to fail page' do
        user.coins = 5
        user.save

        allow(Card).to receive(:find).with('1').and_return(card)

        post "/buy_card/1", {}, 'rack.session' => { user_id: user.id }

        expect(last_response).to be_redirect
        follow_redirect!
        expect(last_request.path).to eq('/fail')
      end
    end
  end

  describe 'GET /cards' do
    it 'renders the cards page' do
      get '/cards'
      expect(last_response).to be_ok
    end
  end
  describe 'POST /use_card' do
    it 'updates user card and redirects to progress page' do
      allow(user).to receive(:save).and_return(true)

      post '/use_card', { card_name: 'NewCard' }, 'rack.session' => { user_id: user.id }

      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/progress')
    end
  end

  describe 'GET /exito' do
    it 'renders the success page' do
      get '/exito'
      expect(last_response).to be_ok
    end
  end

  describe 'GET /fail' do
    it 'renders the fail page' do
      get '/fail'
      expect(last_response).to be_ok
    end
  end
end
