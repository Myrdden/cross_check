require './lib/decor/rec'

module MemoGames
  def memo(name)
    fn = instance_method(name)
    @@game_stats = Hash.new{|k,v| k[v] = {}} if !defined? @@game_stats

    define_method(name) do
      if !@@game_stats.has_key?(name)
        @@game_stats[name] = fn.bind(self).call
      end
      return @@game_stats[name]
    end
  end
end

class Games
  extend Recursive
  extend MemoGames
  attr_reader :games
  def initialize(games)
    @games = games
    @game_stats = {}
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

  memo def highest_total_score
    return get_total_score(@games, []).max
  end

  memo def lowest_total_score
    return get_total_score(@games, []).min
  end

  memo def biggest_blowout
    return get_score_differences(@games, []).max
  end

  memo def percentage_home_wins
    home_wins = @games.count {|x| x[:home_goals] > x[:away_goals]}.to_f
    return (home_wins / @games.count).round(2)
  end

  memo def percentage_visitor_wins
    away_wins = @games.count {|x| x[:away_goals] > x[:home_goals]}.to_f
    return (away_wins / @games.count).round(2)
  end

  memo def average_goals_per_game
    return (get_total_score(@games, []).sum / @games.count.to_f).round(2)
  end

  memo def games_in_seasons
    return @games.group_by {|x| x[:season]}
  end

  def count_of_games_by_season
    seasons = games_in_seasons
    stats = {}
    seasons.each do |season|
      stats[season[0]] = season[1].count
    end
    return stats
  end

  def average_goals_by_season
    seasons = games_in_seasons
    stats = {}
    seasons.each do |season|
      stats[season[0]] = (get_total_score(season[1], []).sum / season[1].count.to_f).round(2)
    end
    return stats
  end
end
