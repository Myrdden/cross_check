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
      game_arg[team[:team_name]] = (team.games.sum{|game| game.goals} \
      / team.games.count.to_f)
    end
    return game_arg.max_by{|k,v| v}[0]
  end

  def worst_offense
    game_arg = {}
    @teams.teams.each do |_, team|
      game_arg[team[:team_name]] = (team.games.sum{|game| game.goals} \
      / team.games.count.to_f)
    end
    return game_arg.min_by{|k,v| v}[0]
  end

  def best_defense
    game_arg = {}
    @teams.teams.each do |_, team|
      game_arg[team[:team_name]] = (team.games.sum{|game| game.against_goals} \
      / team.games.count.to_f)
    end
    return game_arg.min_by{|k,v| v}[0]
  end

  def worst_defense
    game_arg = {}
    @teams.teams.each do |_, team|
      game_arg[team[:team_name]] = (team.games.sum{|game| game.against_goals} \
      / team.games.count.to_f)
    end
    return game_arg.max_by{|k,v| v}[0]
  end

  def highest_scoring_visitor
    game_arg = {}
    @teams.teams.each do |_, team|
      game_arg[team[:team_name]] = team.games.sum do |game|
        if !game.home?
          (game.goals / team.games.count.to_f)
        else
          0.0
        end
      end
    end
    return game_arg.max_by{|k,v| v}[0]
  end

  def lowest_scoring_visitor
    game_arg = {}
    @teams.teams.each do |_, team|
      game_arg[team[:team_name]] = team.games.sum do |game|
        if !game.home?
          (game.goals / team.games.count.to_f)
        else
          0.0
        end
      end
    end
    return game_arg.min_by{|k,v| v}[0]
  end

  def highest_scoring_home_team
    game_arg = {}
    @teams.teams.each do |_, team|
      game_arg[team[:team_name]] = team.games.sum do |game|
        if game.home?
          (game.goals / team.games.count.to_f)
        else
          0.0
        end
      end
    end
    return game_arg.max_by{|k,v| v}[0]
  end

  def lowest_scoring_home_team
    game_arg = {}
    @teams.teams.each do |_, team|
      game_arg[team[:team_name]] = team.games.sum do |game|
        if game.home?
          (game.goals / team.games.count.to_f)
        else
          0.0
        end
      end
    end
    return game_arg.min_by{|k,v| v}[0]
  end

  def winningest_team # game or stats
    #get all teams in data
    #find all games played by team
    #find count of all games won / total games played
    #find highest
    #return string of team_name
  end # returns team name as a string

  def best_fans # stats
    #get all teams in data
    #find all games played by team
    #find count of winning away games / total games.
    #find count of winning home games / total games. ##possible reuse of home team methods
    #determine difference, ln 77 - ln 76
    #find highest
    #eturn string of team_name
  end # returns team name as a string

  def worst_fans #stats
    #get all teams in data
    #find all games played by team
    #find count of winning away games / total games.
    #find count of winning home games / total games. ##possible reuse of home team methods
    #determine difference, ln 86 - ln 87
    #find ALL that are positive and shovel into return array
    #eturn array from 89
  end # returns array of all teams
end
