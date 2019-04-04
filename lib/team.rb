require './lib/decor/rec'

class Team
  attr_reader :id, :stats
  attr_accessor :games, :games_by_season
  def initialize(id, line)
    @id = id
    @stats = line
    @games = []
    @games_by_season = Hash.new({})
  end

  def [](stat); return @stats[stat] end

  def fetch_opponents
    return @games.group_by {|game| game.against}
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
    return (games.count {|x| x.won?} / games.count.to_f).round(2)
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
end