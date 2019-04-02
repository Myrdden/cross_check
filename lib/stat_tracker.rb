require './lib/parse'
require './lib/game'
require './lib/team'
require './lib/stat'

class StatTracker
  def initialize(locations)
    parser = ParseCSV.new if locations.values.all? {|x| File.extname(x) == ".csv"}
    @game = Game.new(parser.parse(locations[:games]))
    # @team = Team.new(parser.parse(locations[:teams]))
    # @stat = Stat.new(parser.parse(locations[:stats]))
  end

  def highest_total_score; return @game.highest_total_score end
  def lowest_total_score; return @game.lowest_total_score end
  def biggest_blowout; return @game.biggest_blowout end
  def percentage_home_wins; return @game.percentage_home_wins end
  def percentage_visitor_wins; return @game.percentage_visitor_wins end
  def count_of_games_by_season; return @game.count_of_games_by_season end
  def average_goals_per_game; return @game.average_goals_per_game end
  def average_goals_by_season; return @game.average_goals_by_season end

end
