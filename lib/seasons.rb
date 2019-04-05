require './lib/teams'

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
        @@season_stats[name][seasonSym] = fn.bind(self).call(season)
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

  def get_average_stats(season, criteria)
    stats = {}
    @teams.teams.each do |_, team|
      if team.games_by_season[season]["R"]
        reg = Team.average_win_percent(team.games_by_season[season]["R"])
      else; reg = 0.0 end
      if team.games_by_season[season]["P"]
        post = Team.average_win_percent(team.games_by_season[season]["P"])
      else post = 0.0 end
      stats[team[criteria]] = (reg - post).round(2)
    end
    return stats
  end

  memo def biggest_bust(season)
    return get_average_stats(season, :team_name).max_by {|k,v| v}[0]
  end

  memo def biggest_surprise(season)
    return get_average_stats(season, :team_name).min_by {|k,v| v}[0]
  end

  memo def asdf()
    retru
  end
end