
class Game
  attr_reader :id, :against
  def initialize(id, against, stats)
    @id = id
    @against = against
    @stats = stats
    @home = stats[:HoA] == "home"
    @won = stats[:won] == "TRUE"
  end

  def [](key); return @stats[key] end
  def won?; return @won end
  def home?; return @home end
end