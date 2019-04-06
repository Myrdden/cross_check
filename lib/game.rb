
class Game
  attr_reader :id, :against, :against_goals,
    :season, :game_type, :goals, :stats
  def initialize(inp)
    @id = inp[0]
    @against = inp[1]
    @against_goals = inp[2].to_i
    @goals = inp[3].to_i
    @season = inp[4]
    @game_type = inp[5]
    @stats = inp[6]
    @stats[:HoA] = @stats.delete(:_ho_a)
    @home = @stats[:HoA] == "home"
    @won = @stats[:won] == "TRUE"
  end

  def [](key); return @stats[key] end
  def won?; return @won end
  def home?; return @home end
end