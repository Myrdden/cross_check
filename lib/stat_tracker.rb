require './lib/parse'
require './lib/game'
require './lib/team'
require './lib/stat'

class StatTracker
  def initialize(locations)
    parser = ParseCSV.new if locations.values.all? {|x| File.extname(x) == ".csv"}
    @game = Game.new(parser.parse(locations[:games]))
    @team = Team.new(parser.parse(locations[:teams]))
    @stat = Stat.new(parser.parse(locations[:stats]))
  end

  def highest_total_score; return @game.highest_total_score end

end