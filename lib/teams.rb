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

  def season_inator(gameID)
    return gameID[0..3] + (gameID[0..3].to_i + 1).to_s
  end

  def best_season(team)
    team_ID = team.to_s
    if !@team_stats.has_key?(:best_season)
      @team_stats[:best_season] = {}
    end
    if !@team_stats.has_key?(team_ID)
      #grab all from stats that match id.
      total_games = @stats.stats.map do |stat|
        if stat[:team_id] == team_ID && stat[:won] == "TRUE"
          season_inator(stat[:game_id]).to_i
        end
      end.compact
      temp = total_games.group_by{|season| season}.max_by(&:size)
      @team_stats[:best_season][team_ID] = temp[0]
    end
    return @team_stats[:best_season][team_ID]
  end

  def worst_season(team)
    team_ID = team.to_sym
    if !@team_stats.has_key?(:worst_season)
      @team_stats[:worst_season] = {}
    end
    if !@team_stats.has_key?(team_ID)
      #LOGIX
    end

    return @team_stats[:best_season][team_ID]
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
