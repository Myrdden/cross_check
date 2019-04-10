require 'erb'
require 'sinatra'
require 'sinatra/reloader'
require './lib/stat_tracker'

set :public_folder, File.dirname(__FILE__)

class StatBuilder
  attr_reader :stat_tracker
  def initialize
    game_path = '../cross_check_spec_harness/data/game.csv'
    team_path = '../cross_check_spec_harness/data/team_info.csv'
    game_teams_path = '../cross_check_spec_harness/data/game_teams_stats.csv'

    locations = {
      games: game_path,
      teams: team_path,
      stats: game_teams_path
    }
    @stat_tracker = StatTracker.new(locations)
  end

  def get_binding
    binding
  end
end

get '/' do
  
end

get '/teams/:team_id' do |team_id|
  builder = StatBuilder.new
  @stats = builder.stat_tracker
  @team = team_id
  template = File.read('./site/templates/team_temp.html')
  erb template
end
