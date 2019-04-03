require './lib/decor/rec'

class Team
  attr_reader :id
  attr_writer :games
  def initialize(id, line)
    @id = id
    @stats = line
    @games = []
  end

end