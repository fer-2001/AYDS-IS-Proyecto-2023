# frozen_string_literal: true

require_relative '../../controllers/others_controller'
require_relative '../../models/user'
require_relative '../../models/card'

describe OthersController do
  include Rack::Test::Methods

  def app
    OthersController
  end

  let(:user) { User.create(name: 'John', password: 'password', points: 0) }
  let(:report_params) { { user_id: user.id, description: 'Test Report', date: '2023-11-13' } }
  let(:suggestion_params) { { user_id: user.id, description: 'Test Suggestion', date: '2023-11-13' } }

  before do
    # Autenticar al usuario antes de cada prueba
    allow(User).to receive(:find).with(user.id).and_return(user)
    set_cookie("user_id=#{user.id}")
  end

  describe 'Reports, Suggestions, and Leaderboard Pages' do
    describe 'GET /reports' do
      it 'renders the reports page' do
        get '/reports'
        expect(last_response).to be_ok
      end
    end

    describe 'POST /reports' do
      it 'creates a new report and renders the reports page' do
        initial_reports_count = 0

        post '/reports', report_params

        expect(Report.count).to eq(initial_reports_count + 1)
        expect(last_response).to be_ok
      end
    end

    describe 'GET /suggestion' do
      it 'renders the suggestion page' do
        get '/suggestion'
        expect(last_response).to be_ok
      end
    end

    describe 'POST /suggestion' do
      it 'creates a new suggestion and renders the suggestion page' do
        initial_suggestions_count = 0

        post '/suggestion', suggestion_params
        expect(Suggestion.count).to eq(initial_suggestions_count + 1)
        expect(last_response).to be_ok
      end
    end

    describe 'GET /leaderboard' do
      it 'renders the leaderboard page' do
        get '/leaderboard'
        expect(last_response).to be_ok
      end
    end

    
  end
end
