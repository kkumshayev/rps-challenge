require 'sinatra'
require 'shotgun'
# require './lib/player'
# require './lib/game'

class RockPaperScissors < Sinatra::Base
  enable :sessions
  set :session_secret, 'yes'

  get '/' do
    erb(:enter_name)
  end

  post '/name' do
    session[:player] = params[:player]
    player = Player.new(session[:player])
    $game = Game.new(player)
    session[:game] = $game
    redirect '/play'
  end

  get '/play' do
    @game = session[:game]
    erb(:play)
  end

  run! if app_file == $0
end
