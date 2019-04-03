
class Game
  attr_reader :id, :against
  def initialize(id, against, stats)
    @id = id
    @against = against
    @stats = stats
    @home = stats[:HoA] == "home"
    @won = stats[:won] == "TRUE"
  end

end