
class Game
  attr_reader :id, :against, :against_goals
  def initialize(id, against, against_goals, stats)
    @id = id
    @against = against
    @against_goals = against_goals.to_i
    @stats = stats
    @home = stats[:HoA] == "home"
    @won = stats[:won] == "TRUE"
  end

  def [](key); return @stats[key] end
  def won?; return @won end
  def home?; return @home end
end