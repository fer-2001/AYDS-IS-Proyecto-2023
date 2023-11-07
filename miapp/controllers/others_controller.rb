class OthersController < Sinatra::Application
  set :public_folder, File.expand_path('../views', __dir__)
  set :views, File.expand_path('../views', __dir__)


  get '/reports' do
    @reports = Report.all
    erb :reports
  end


  post '/reports' do
    session[:user_id]
    @report = Report.find_or_create_by(user_id: params[:user_id], description: params[:description],
                                       date: params[:date])
    erb :reports
  end

  get '/suggestion' do
    erb :suggestion
  end


  post '/suggestion' do
    session[:user_id]
    @suggestion = Suggestion.find_or_create_by(user_id: params[:user_id], description: params[:description],
                                               date: params[:date])
    erb :suggestion
  end

  get '/leaderboard' do
    @datos = User.order(points: :desc).limit(5)
    erb :leaderboard
  end
end
