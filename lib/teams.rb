require './lib/games'

class Teams
  def initialize(teams, game, stats)
    @games = game.games
    @teams = teams
    @stats = stats
    @team_stats = {}
  end

  def team_info(team)
    return @teams.find {|team| team[:team_id] == team}
  end

  def best_season(team)
    team_ID = team.to_sym
    if !@team_stats.has_key?(:best_season)
      @team_stats[:best_season] = {}
    end
    if !@team_stats.has_key?(team_ID)
      #LOGIX
    end
    return @team_stats[:best_season][team_ID]
  end

  def worst_season(team)
  end

  def average_win_percentage(team)
  end

  def most_goals_scored(team)
  end

  def fewest_goals_scored(team)
  end

  def favourite_opponent(team)
  end

  def rival(team)
  end

  def biggest_team_blowout
  end

  def worst_loss(team)
  end

  def head_to_head(team)
  end

  def seasonal_summary(team)
  end
end