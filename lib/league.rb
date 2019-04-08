module MemoLeague
  def memo(name)
    fn = instance_method(name)
    @@league_stats = Hash.new{|k,v| k[v] = {}} if !defined? @@league_stats

    define_method(name) do
      if !@@league_stats.has_key?(name)
        @@league_stats[name] = fn.bind(self).call
      end
      return @@league_stats[name]
    end
  end
end

class League
  extend MemoLeague
  def initialize(teams)
    @teams = teams
  end

  def count_of_teams
    return @teams.teams.count
  end

  def best_offense # highest goals per game
    game_arg = {}
    @teams.teams.each do |_, team|
      game_arg[team] = (team.games.sum{|game| game.goals} \
      / team.games.count.to_f)
    end
    return game_arg.max_by{|k,v| v}[0][:team_name]
  end

  def worst_offense
    game_arg = {}
    @teams.teams.each do |_, team|
      game_arg[team] = (team.games.sum{|game| game.goals} \
      / team.games.count.to_f)
    end
    return game_arg.min_by{|k,v| v}[0][:team_name]
  end

  def best_defense
    game_arg = {}
    @teams.teams.each do |_, team|
      game_arg[team] = (team.games.sum{|game| game.against_goals} \
      / team.games.count.to_f)
    end
    return game_arg.min_by{|k,v| v}[0][:team_name]
  end

  def worst_defense
    game_arg = {}
    @teams.teams.each do |_, team|
      game_arg[team] = (team.games.sum{|game| game.against_goals} \
      / team.games.count.to_f)
    end
    return game_arg.max_by{|k,v| v}[0][:team_name]
  end

  def highest_scoring_visitor
    game_arg = {}
    @teams.teams.each do |_, team|
      game_arg[team] = team.games.sum do |game|
        if !game.home?
          (game.goals / team.games.count.to_f)
        else
          0.0
        end
      end
    end
    return game_arg.max_by{|k,v| v}[0][:team_name]
  end

  def lowest_scoring_visitor
    game_arg = {}
    @teams.teams.each do |_, team|
      game_arg[team] = team.games.sum do |game|
        if !game.home?
          (game.goals / team.games.count.to_f)
        else
          0.0
        end
      end
    end
    return game_arg.min_by{|k,v| v}[0][:team_name]
  end

  def highest_scoring_home_team
    game_arg = {}
    @teams.teams.each do |_, team|
      game_arg[team] = team.games.sum do |game|
        if game.home?
          (game.goals / team.games.count.to_f)
        else
          0.0
        end
      end
    end
    return game_arg.max_by{|k,v| v}[0][:team_name]
  end

  def lowest_scoring_home_team
    game_arg = {}
    @teams.teams.each do |_, team|
      game_arg[team] = team.games.sum do |game|
        if game.home?
          (game.goals / team.games.count.to_f)
        else
          0.0
        end
      end
    end
    return game_arg.min_by{|k,v| v}[0][:team_name]
  end

  def winningest_team
    game_arg = {}
    @teams.teams.each do |_, team|
      game_arg[team] = (team.games.count{|game| game.won?} \
      / team.games.count.to_f)
    end
    return game_arg.max_by{|k,v| v}[0][:team_name]
  end

  def best_fans
    game_arg = {}
    @teams.teams.each do |_, team|
      home_win = (team.games.count{|game| game.won? && game.home?} / \
          team.games.count{|game| game.home?}.to_f)
      away_win = (team.games.count{|game| game.won? && !game.home?} / \
        team.games.count{|game| !game.home?}.to_f)
      game_arg[team] = (home_win - away_win)
    end
    return game_arg.max_by{|k,v| v}[0][:team_name]
  end

  def worst_fans
    game_arg = []
    @teams.teams.each do |_, team|
      home_win = (team.games.count{|game| game.won? && game.home?} / \
          team.games.count{|game| game.home?}.to_f)
      away_win = (team.games.count{|game| game.won? && !game.home?} / \
        team.games.count{|game| !game.home?}.to_f)
      game_arg << team[:team_name] if (away_win - home_win) > 0
    end
    return game_arg
  end
end
