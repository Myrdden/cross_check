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

  ##Need memoizer

  def count_of_teams
    return @teams.teams.count
  end

  def best_offense # highest goals per game
    game_average = {}
    @teams.teams.each do |_, team|
      game_average[team[:team_name]] = (team.games.sum{|game| game.goals} / team.games.count.to_f)
    end
    return game_average.max_by{|k,v| v}[0]
  end

  def worst_offense
    game_average = {}
    @teams.teams.each do |_, team|
      game_average[team[:team_name]] = (team.games.sum{|game| game.goals} / team.games.count.to_f)
    end
    return game_average.min_by{|k,v| v}[0]
  end

  def best_defense # game or stats
    #get all teams in data
    #find all games played by team
    #count all goals allowed by team / all games played.
    #find highest average
    #return string of team_name
  end # returns team name as a string

  def worst_defense # game stats
    #inverse of above
  end # returns team name as a string

  def highest_scoring_visitor #game stats
    #get all teams in data
    #find all games played by team && while team away flag from game
    #count all goals scored by subset above / total games played by subset above
    #find highest average
    #return string of team_name
  end # returns team name as a string

  def lowest_scoring_visitor #game stats
    #inverse of above
  end # returns team name as a string

  def highest_scoring_home_team #game stats
    #get all teams in data
    #find all games played by team && while team home flag from game
    #count all goals scored by subset above / total games played by subset above
    #find highest average
    #return string of team_name
  end # returns team name as a string

  def lowest_scoring_home_team # stats
    #inverse of above
  end # returns team name as a string

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
