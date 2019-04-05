class Stats

  attr_reader :stats

  def initialize(stats)
    @stats = stats
  end

  ##helper method -
  #get all teams in data
  #find all games played by team

  def biggest_bust(seasonasstring)
    #get all teams in data
    #find all games played by team in season  - given by arg
    #get subset of 95 where p is in season marker
    #count games won in subset on 95 / total games in subset on 95
    #get subset of 85 where r is in season marker
    #count games won in subset on 98 / total games in subset on 98
    #result of line 97 - line 99
    #find highest number
    #return team name of result of line 101
  end # returns team name as a string

  def biggest_suprise(seasonasstring)
    #as above, but change line 100 to reverse operations, regular percentage - postseason percentage
  end # returns team name as a string

  def winningest_coach(seasonasstring) # coach name in game team stats
    #per season, get list of all coaches - given by arg
    #per coach, find all games played by that coach
    #then count of all games won / count of all games played
    #find highest
    #return name of coach found in 114
  end # returns coach name as string

  def worst_coach(seasonasstring) # coach name in game team stats
    #inverse of above
  end # returns coach name as string

  def most_accurate_team(seasonasstring) # shots in game team stats
    #get a list of all teams that played in that season - given by arg
    #use above list to sum all shots across all games in season
    #divide above by goals made across all games in season
    #find highest percentage
    #return team name as found in 127
  end # returns team name as string

  def least_accurate_team(seasonasstring) # shots in game team stats
    #inverse of above
  end # returns team name as string

  def most_hits(seasonasstring) # shots in game team stats
    #get a list of all teams that played in that season
    #use above list to sum all shots across all games in season
    #find highest across list
    #return team name as found in 139
  end # returns team name as string

  def fewest_hits(seasonasstring) # shots in game team stats
    #inverse of above
  end # returns team name as string

  def power_play_goal_percentage(seasonasstring) # power_play info in game team stat
    #find list of all games in season given by arg
    #sum all power play goals
    #sum all power play oppertunities
    #divide line 146 and line 147
    #return total of above
  end # returns percentage as float

end
