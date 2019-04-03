require './lib/games'

class Teams
  def initialize(teams, games, stats)
    @games = games.games
    @teams = teams
    @stats = stats.stats
    @team_stats = {}
  end

  def team_info(team)
    return @teams.find {|team| team[:team_id] == team}
  end

  def season_inator(gameID)
    return gameID[0..3] + (gameID[0..3].to_i + 1).to_s
  end

  def best_season(team)
    team_ID = team.to_sym
    if !@team_stats.has_key?(:best_season)
      @team_stats[:best_season] = {}
    end
    if !@team_stats[:best_season].has_key?(team_ID)
      total_games = @stats.map do |stat|
        if stat[:team_id] == team && stat[:won] == "TRUE"
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
    if !@team_stats[:worst_season].has_key?(team_ID)
      total_games = @stats.map do |stat|
        if stat[:team_id] == team && stat[:won] == "FALSE"
          season_inator(stat[:game_id]).to_i
        end
      end.compact
      temp = total_games.group_by{|season| season}.max_by(&:size)
      @team_stats[:worst_season][team_ID] = temp[0]
    end
    return @team_stats[:worst_season][team_ID]
  end

  def average_win_percentage(team)
    team_ID = team.to_sym
    if !@team_stats.has_key?(:average_win)
      @team_stats[:average_win] = {}
    end
    if !@team_stats[:average_win].has_key?(team_ID)
      total_games = @stats.count {|stat| stat[:team_id] == team}
      won_games = @stats.count {|stat| stat[:team_id] == team && \
      stat[:won] == "TRUE"}
      @team_stats[:average_win][team_ID] = ((won_games.to_f / total_games) \
       * 100).round(2)
    end
    return @team_stats[:average_win][team_ID]
  end

  def most_goals_scored(team)
    team_ID = team.to_sym
    if !@team_stats.has_key?(:most_goals_scored)
      @team_stats[:most_goals_scored] = {}
    end
    if !@team_stats[:most_goals_scored].has_key?(team_ID)
      team_games = @stats.find_all{|stat| stat[:team_id] == team}
      temp = team_games.max_by{|stat| stat[:goals].to_i}
      @team_stats[:most_goals_scored][team_ID] = temp[:goals].to_i
    end
    return @team_stats[:most_goals_scored][team_ID]
  end

  def fewest_goals_scored(team)
    team_ID = team.to_sym
    if !@team_stats.has_key?(:fewest_goals_scored)
      @team_stats[:fewest_goals_scored] = {}
    end
    if !@team_stats[:fewest_goals_scored].has_key?(team_ID)
      team_games = @stats.find_all{|stat| stat[:team_id] == team}
      temp = team_games.min_by{|stat| stat[:goals].to_i}
      @team_stats[:fewest_goals_scored][team_ID] = temp[:goals].to_i
    end
    return @team_stats[:fewest_goals_scored][team_ID]
  end

  def favorite_opponent(team)
    team_ID = team.to_sym
    if !@team_stats.has_key?(:fav_opponent)
      @team_stats[:fav_opponent] = {}
    end
    if !@team_stats[:fav_opponent].has_key?(team_ID)
      team_games = @stats.group_by {|x| x[:game_id]}
      team_games2 = team_games.find_all {|x| x[1].any? {|x| x[:team_id] == team}}
      opponents = team_games2.flat_map {|x| x[1].select {|x| x[:team_id] != team}}
      opponents2 = opponents.group_by {|x| x[:team_id]}.to_a
      favourite = opponents2.max_by {|x| x[1].count}[0]
      @team_stats[:fav_opponent][team_ID] = @teams.find {|x| x[:team_id] == favourite}[:teamName]
    end
    p @team_stats[:fav_opponent][team_ID]
    return @team_stats[:fav_opponent][team_ID]
  end

  def rival(team)
    #find all games played by team given by argument
    #find all games played against each other team?
    #find
  end

  def biggest_team_blowout
    #use normal biggest blowout algo with an argument
    #gather subest of all games played by team.
    #refactor code to get all games played by team reused several times.
  end

  def worst_loss(team)
    #inverse of above
  end

  def fetch_opponents(team)
    return @teams.reject {|x| x[:team_id] == team}
  end

  def head_to_head(team)
    opponents = fetch_opponents(team)
    #get games played by team, see above for refactor
    #get a subset - each loop of opponents? with every game played by that team
    #since we already grouped by games olayed by the team above, we can use the win/loss to
    #extrapolte a win percentage.
    require 'pry'; binding.pry
  end

  def seasonal_summary(team)
  end
end
