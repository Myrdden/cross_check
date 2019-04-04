require './lib/games'

module MemoSeasons
  def memo(name)
    fn = instance_method(name)
    @@season_stats = Hash.new{|k,v| k[v] = {}} if !defined? @@season_stats

    define_method(name) do |season|
      seasonSym = season.to_sym
      if !@@season_stats.has_key?(name)
        @@season_stats[name] = {}
      end
      if !@@season_stats[name].has_key?(seasonSym)
        @@season_stats[name][seasonSym] = fn.bind(self).call(seasonSym)
      end
      return @@season_stats[name][seasonSym]
    end
  end
end

class Seasons
  extend MemoSeasons
  def initialize(teams)
    @teams = teams
  end

  memo def biggest_bust(season)
    seasonSym = season.to_sym
    stats = {}
    @teams.each do |team|
      reg = Team.average_win_percent(team.games_by_season[seasonSym]["R"])
      post = Team.average_win_percent(team.games_by_season[seasonSym]["P"])
      stats[team[3]] = reg - post
    end
    return stats.max.key
  end

  memo def biggest_surprise(season)
    seasonSym = season.to_sym
    stats = {}
    @teams.each do |team|
      reg = Team.average_win_percent(team.games[seasonSym]["R"])
      post = Team.average_win_percent(team.games[seasonSym]["P"])
      stats[team[3]] = reg - post
    end
    return stats.max.key
  end
end