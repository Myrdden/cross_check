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
end