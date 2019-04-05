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

  memo def get_average_stats(season)
    stats = {}
    @teams.teams.each do |_, team|
      if team.games_by_season[season]["R"]
        reg = Team.average_win_percent(team.games_by_season[season]["R"])
      else; reg = 0.0 end
      if team.games_by_season[season]["P"]
        post = Team.average_win_percent(team.games_by_season[season]["P"])
      else post = 0.0 end
      stats[team[:team_name]] = (reg - post).round(2)
    end
    return stats
  end

  memo def get_average_stats_by_coach(season)
    stats = {}
    @teams.teams.each do |_, team|
      if team.games_by_season[season]["R"]
        reg = Team.average_win_percent_by_coach(team.games_by_season[season]["R"])
      else; reg = {} end
      if team.games_by_season[season]["P"]
        post = Team.average_win_percent_by_coach(team.games_by_season[season]["P"])
      else post = {} end
      reg.merge!(post) {|_,o,n| ((o + n) / 2)}
      stats.merge!(reg)
    end
    return stats
  end

  memo def biggest_bust(season)
    return get_average_stats(season).max_by {|k,v| v}[0]
  end

  memo def biggest_surprise(season)
    return get_average_stats(season).min_by {|k,v| v}[0]
  end

  memo def winningest_coach(season)
    return get_average_stats_by_coach(season).max_by {|k,v| v}[0]
  end

  memo def worst_coach(season)
    return get_average_stats_by_coach(season).min_by {|k,v| v}[0]
  end
end