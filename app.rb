require 'sinatra'
require 'shotgun'
# require 'rack'
require './lib/player'
require './lib/game'

class RockPaperScissors < Sinatra::Base
  enable :sessions
  set :session_secret, 'yes'

  get '/' do
    erb(:enter_name)
  end

  post '/name' do
    session[:player] = params[:player]
    @player = Player.new(session[:player])
    session[:game] = Game.new(@player)
    redirect '/play'
  end

  get '/play' do
    @game = session[:game]
    erb(:play)
  end

  post '/attack' do
    session[:players_choice] = params[:players_choice]
    params[:cpu_choice] = ['Rock','Paper','Scissors'].sample
    session[:cpu_choice] = params[:cpu_choice]
    redirect '/end'
  end

  get '/end' do
    if session[:players_choice] == session[:cpu_choice]
      redirect '/draw'
    elsif session[:players_choice] == 'Rock' && session[:cpu_choice] == 'Scissors'
      redirect '/player_wins'
    elsif session[:players_choice] == 'Paper' && session[:cpu_choice] == 'Rock'
      redirect '/player_wins'
    elsif session[:players_choice] == 'Scissors' && session[:cpu_choice] == 'Paper'
      redirect '/player_wins'
    elsif session[:cpu_choice] == 'Rock' && session[:players_choice] == 'Scissors'
      redirect '/player_loses'
    elsif session[:cpu_choice] == 'Paper' && session[:players_choice] == 'Rock'
      redirect '/player_loses'
    elsif session[:cpu_choice] == 'Scissors' && session[:players_choice] == 'Paper'
      redirect '/player_loses'
    else
      redirect '/try_again'
    end
  end

  get '/draw' do
    erb(:replay)
  end

  get '/player_wins' do
    "You win!"
  end

  get '/player_loses' do
    "You lose!"
  end

  get '/try_again' do
    'Try again'
    erb(:replay)
  end

  run! if app_file == $0
end
