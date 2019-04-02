require './lib/parse'
require './lib/games'
require './lib/teams'
require './lib/stats'

class StatTracker
  def initialize(locations)
    parser = ParseCSV.new if locations.values.all? {|x| File.extname(x) == ".csv"}
    @games = Games.new(parser.parse(locations[:games]))
    #@stats = Stats.new(parser.parse(locations[:stats]))
    #@teams = Teams.new(parser.parse(locations[:teams]), @stats)
  end

  def highest_total_score; return @games.highest_total_score end
  def lowest_total_score; return @games.lowest_total_score end
  def biggest_blowout; return @games.biggest_blowout end
  def percentage_home_wins; return @games.percentage_home_wins end
  def percentage_visitor_wins; return @games.percentage_visitor_wins end
  def count_of_games_by_season; return @games.count_of_games_by_season end
  def average_goals_per_game; return @games.average_goals_per_game end
  def average_goals_by_season; return @games.average_goals_by_season end
end
