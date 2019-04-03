class Stats

  attr_reader :stats

  def initialize(stats)
    @stats = stats
  end

  ##helper method -
  #get all teams in data
  #find all games played by team

  def count_of_teams
    #get count of total teams in data. game or game stats can be read in?
  end #returns total as an int

  def best_offense # highest goals per game
    #get all teams in data
    #find all games played by team
    #count all goals scored by team / all games played.
    #find highest average
    #return string of team_name
  end # returns team name as a string

  def worst_offense
    #inverse of above.
  end # returns team name as a string

  def best_defense
    #get all teams in data
    #find all games played by team
    #count all goals allowed by team / all games played.
    #find highest average
    #return string of team_name
  end # returns team name as a string

  def worst_defence
    #inverse of above
  end # returns team name as a string

  def highest_scoring_visitor
    #get all teams in data
    #find all games played by team && while team away flag from game
    #count all goals scored by subset above / total games played by subset above
    #find highest average
    #return string of team_name
  end # returns team name as a string

  def lowest_scoring_visitor
    #inverse of above
  end # returns team name as a string

  def highest_scoring_home_team
    #get all teams in data
    #find all games played by team && while team home flag from game
    #count all goals scored by subset above / total games played by subset above
    #find highest average
    #return string of team_name
  end # returns team name as a string

  def lowest_scoring_home_team
    #inverse of above
  end # returns team name as a string

  def winningest_team
    #get all teams in data
    #find all games played by team
    #find count of all games won / total games played
    #find highest
    #return string of team_name
  end # returns team name as a string

  def best_fans
    #get all teams in data
    #find all games played by team
    #find count of winning away games / total games.
    #find count of winning home games / total games. ##possible reuse of home team methods
    #determine difference, ln 77 - ln 76
    #find highest
    #eturn string of team_name
  end # returns team name as a string

  def worst_fans
    #get all teams in data
    #find all games played by team
    #find count of winning away games / total games.
    #find count of winning home games / total games. ##possible reuse of home team methods
    #determine difference, ln 86 - ln 87
    #find ALL that are positive and shovel into return array
    #eturn array from 89
  end # returns array of all teams
