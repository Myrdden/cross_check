require './lib/decor/rec'

class Team
  attr_reader :id, :stats
  attr_accessor :games, :games_by_season
  def initialize(id, line)
    @id = id
    @stats = line
    @games = []
    @games_by_season = {}
  end

  def [](stat); return @stats[stat] end

  def fetch_opponents
    return @games.group_by {|game| game.against}
  end

  def win_percentages
    win_percs = {}
    fetch_opponents.each do |k,v|
      win_percs[k] = (v.count {|x| x.won?} / v.count.to_f).round(2)
    end
    return win_percs
  end

  def win_ratios
    ratios = []
    @games.each do |game|
      ratios << game.goals - game.against_goals
    end
    return ratios
  end

  def self.average_win_percent(games)
    return (games.count {|x| x.won?} / games.count.to_f).round(2)
  end

  def self.average_win_percent_by_coach(games)
    temp = {}
    games.each do |game|
      temp[game[:head_coach]] ||= []
      temp[game[:head_coach]] << game
    end
    stats = {}
    temp.each do |k,v|
      stats[k] = (v.count {|x| x.won?} / v.count.to_f)#.round(2)
    end
    return stats
  end

  def self.shots_to_goals_ratio(games)
    ratios = []
    games.each do |game|
      if game[:goals].to_i != 0
        ratios << (game[:goals].to_f / game[:shots].to_f)#.round(2)
      else
        ratios << game[:goals].to_f
      end
    end
    return (ratios.sum / ratios.count)#.round(2)
  end

  def self.average_goals_for(games)
    goals = []
    games.each do |game|
      goals << game.goals
    end
    return (goals.sum / goals.length.to_f).round(2)
  end

  def self.average_goals_against(games)
    goals = []
    games.each do |game|
      goals << game.against_goals
    end
    return (goals.sum / goals.length.to_f).round(2)
  end

  def self.total_goals_for(games)
    return games.sum {|x| x.goals}
  end

  def self.total_goals_against(games)
    return games.sum {|x| x.against_goals}
  end

  def self.total_hits(games)
    return games.sum {|x| x[:hits].to_i}
  end

  def self.powerplays(games)
    return (games.sum {|x| x[:power_play_goals].to_f} \
      / games.sum {|x| x[:goals].to_f}).floor(2)
  end
end
