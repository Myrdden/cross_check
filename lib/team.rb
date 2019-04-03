require './lib/decor/rec'

class Team
  attr_reader :id
  attr_accessor :games
  def initialize(id, line)
    @id = id
    @stats = line
    @games = []
  end

end