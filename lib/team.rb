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

  def self.win_ratios(games)
    ratios = []
    games.each do |game|
      ratios << game[:goals].to_i - game.against_goals
    end
    return ratios
  end
end