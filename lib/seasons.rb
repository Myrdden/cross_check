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
      regs = team.games_by_season[season].find_all {|x| x.game_type == "R"}
      reg = Team.average_win_percent(regs) if !regs.empty?
      reg ||= 0.0
      posts = team.games_by_season[season].find_all {|x| x.game_type == "P"}
      post = Team.average_win_percent(posts) if !posts.empty?
      post ||= 0.0
      stats[team[:team_name]] = (reg - post).round(2)
    end
    return stats
  end

  memo def get_average_stats_by_coach(season)
    stats = {}
    @teams.teams.each do |_, team|
      if team.games_by_season[season]
        reg = Team.average_win_percent_by_coach(team.games_by_season[season])
        stats.merge!(reg)
      end
    end
    return stats
  end

  memo def get_shots_goals_ratio(season)
    stats = {}
    @teams.teams.each do |_, team|
      if team.games_by_season[season]
        stats[team[:team_name]] = Team.shots_to_goals_ratio(team.games_by_season[season])
      end
    end
    return stats
  end

  memo def get_hits(season)
    stats = {}
    @teams.teams.each do |_, team|
      if team.games_by_season[season]
        stats[team[:team_name]] = Team.total_hits(team.games_by_season[season])
      end
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

  memo def most_accurate_team(season)
    return get_shots_goals_ratio(season).min_by {|k,v| v}[0]
  end

  memo def least_accurate_team(season)

  end

  memo def most_hits(season)
    return get_hits(season).max_by {|k,v| v}[0]
  end

  memo def fewest_hits(season)
    return get_hits(season).min_by {|k,v| v}[0]
  end
end