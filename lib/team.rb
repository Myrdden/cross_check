require './lib/decor/rec'

class Team
  attr_reader :id, :stats
  attr_accessor :games
  def initialize(id, line)
    @id = id
    @stats = line
    @games = []
  end

  def [](stat); return @stats[stat] end

  def fetch_opponents
    return @games.group_by {|game| game.against}
  end

  def self.fetch_opponents(games)
    return games.group_by {|game| game.against}
  end

  def win_percentages
    winPercs = {}
    fetch_opponents.each do |k,v|
      winPercs[k] = (v.count {|x| x.won?} / v.count.to_f).round(2)
    end
    return winPercs
  end

  def win_ratios
    ratios = []
    @games.each do |game|
      ratios << game[:goals].to_i - game.against_goals
    end
    return ratios
  end

  def self.average_win_percent(games)
    winPercs = []
    self.fetch_opponents(games).each do |k,v|
      winPercs << (v.count {|x| x.won?} / v.count.to_f).round(2)
    end
    return (winPercs.sum / winPercs.length).round(2)
  end

  def self.average_goals_for(games)
    goals = []
    games.each do |game|
      goals << game[:goals].to_i
    end
    return (goals.sum / goals.length).round(2)
  end

  def self.average_goals_against(games)
    goals = []
    games.each do |game|
      goals << game.against_goals
    end
    return (goals.sum / goals.length).round(2)
  end

  def self.total_goals_for(games)
    return games.sum {|x| x[:goals].to_i}
  end

  def self.total_goals_against(games)
    return games.sum {|x| x.against_goals}
  end
end