
class Game
  attr_reader :id, :against, :against_goals,
    :season, :game_type
  def initialize(inp)
    @id = inp[0]
    @against = inp[1]
    @against_goals = inp[2].to_i
    @season = inp[3]
    @game_type = inp[4]
    @stats = inp[5]
    @home = @stats[:HoA] == "home"
    @won = @stats[:won] == "TRUE"
  end

  def [](key); return @stats[key] end
  def won?; return @won end
  def home?; return @home end
end