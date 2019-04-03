require './lib/parse'
require './lib/games'
require './lib/teams'
require './lib/stats'

class StatTracker
  def initialize(locations)
    if locations.values.all? {|x| File.extname(x) == ".csv"}
      @teams = Teams.new(ParseCSV.teams_setup(locations[:teams]))
      @games = Games.new(ParseCSV.games_setup(@teams, locations[:games], locations[:stats]))
    end
  end

  def highest_total_score; return @games.highest_total_score end
  def lowest_total_score; return @games.lowest_total_score end
  def biggest_blowout; return @games.biggest_blowout end
  def percentage_home_wins; return @games.percentage_home_wins end
  def percentage_visitor_wins; return @games.percentage_visitor_wins end
  def count_of_games_by_season; return @games.count_of_games_by_season end
  def average_goals_per_game; return @games.average_goals_per_game end
  def average_goals_by_season; return @games.average_goals_by_season end
  def team_info(team); return @teams.team_info(team) end
  def best_season(team); return @teams.best_season(team) end
  def worst_season(team); return @teams.worst_season(team) end
  def average_win_percentage(team); return @teams.average_win_percentage(team) end
  def most_goals_scored(team); return @teams.most_goals_scored(team) end
  def fewest_goals_scored(team); return @teams.fewest_goals_scored(team) end
  def favorite_opponent(team); return @teams.favorite_opponent(team) end
  def rival(team); return @teams.rival(team) end
  def head_to_head(team); return @teams.head_to_head(team) end

end