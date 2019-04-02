class Game
  def initialize(games)
    @games = games
    @game_stats = Hash.new
  end

  rec def get_total_score(inp, out) #::[Games] -> [Total Scores]
    return out if inp.empty?
    x, *xs = inp
    out << x[:home_goals].to_i + x[:away_goals].to_i
    get_total_score(xs, out)
  end

  rec def get_score_differences(inp, out)
    return out if inp.empty?
    x, *xs = inp
    home = x[:home_goals].to_i
    away = x[:away_goals].to_i
    if home >= away
      out << home - away
    else
      out << away - home
    end
    get_score_differences(xs, out)
  end

  def highest_total_score
    if !@game_stats.has_key?(:highest)
      @game_stats[:highest] = get_total_score(@games, []).max
    end
    return @game_stats[:highest]
  end

  def lowest_total_score
    if !@game_stats.has_key?(:lowest)
      @game_stats[:lowest] = get_total_score(@games, []).min
    end
    return @game_stats[:lowest]
  end

  def biggest_blowout
    if !@game_stats.has_key?(:difference)
      @game_stats[:difference] = get_score_differences(@games, []).max
    end
    return @game_stats[:difference]
  end

  def percentage_home_wins
    if !@game_stats.has_key?(:home_wins)
      homeWins = @games.count {|x| x[:home_goals] > x[:away_goals]}.to_f
      @game_stats[:home_wins] = ((homeWins / @games.count) * 100.0).round(2)
    end
    return @game_stats[:home_wins]
  end

  def percentage_visitor_wins
    if !@game_stats.has_key?(:away_wins)
      awayWins = @games.count {|x| x[:away_goals] > x[:home_goals]}.to_f
      @game_stats[:away_wins] = ((awayWins / @games.count) * 100.0).round(2)
    end
    return @game_stats[:away_wins]
  end

  def count_of_games_by_season
    if !@game_stats.has_key?(:games_season)
      seasons = @games.map {|x| x[:season]}.uniq
      @game_stats[:games_season] = {}
      seasons.each do |season|
        @game_stats[:games_season][season] = @games.count \
          {|x| x[:season] == season}
      end
    end
    return @game_stats[:games_season]
  end

  def average_goals_per_game
    if !@game_stats.has_key?(:average_game)
      @game_stats[:average_game] = (get_total_score(@games, []).sum / \
        @games.count.to_f).round(2)
    end
    return @game_stats[:average_game]
  end

  def average_goals_by_season
    if !@game_stats.has_key?(:average_season)
      seasons = @games.map {|x| x[:season]}.uniq
      @game_stats[:average_season] = {}
      seasons.each do |season|
        seasonGames = @games.map {|x| x[:season] == season}
        @game_stats[:average_season][season] = \
          (get_total_score(seasonGames, []).sum / seasonGames.count.to_f).round(2)
      end
    end
    return @game_stats[:average_season]
  end
end