require './lib/decor/rec'
require './lib/game'
require './lib/team'

class ParseCSV
  extend Recursive
  def self.teams_setup(teamfile)
    lines= IO.readlines(teamfile)
    teams = {}
    keys = words(lines.pop)[1..-1]
    lines.each do |line|
      line = words(line)
      teams[line[0].to_sym] = Team.new(line[0].to_i, hashify(keys, line[1..-1], {}))
    end
    return teams
  end

  def words(line)
    return line.chomp.split(/,/).map {|x| x[0] == "\"" ? x[1..-2] : x}
  end

  def self.games_setup(teams, gamefile, statfile)
    @stats = IO.readlines(statfile).map(&:words)
    @keys = @stats.pop
    lines = IO.readlines(gamefile)
    games = []
    keys = words(lines[0])
    lines.each do |line|
      games << hashify(keys, line, {})
      teams[line[4].to_sym].games << Game.new(line[4], line[5], getStats(line[0], line[4]))
      teams[line[5].to_sym].games << Game.new(line[5], line[4], getStats(line[0], line[5]))
    end
    return games
  end

  def getStats(game, team)
    stat = @stats.find {|x| x[0] == game && x[1] == team}
    return hashify(@keys, stat, {})
  end

  rec def hashify(keysIn, valuesIn, out)
    return out if keysIn.empty? || valuesIn.empty?
    key, *keys = keysIn
    value, *values = valuesIn
    out[key] = value
    hashify(keys, values, out)
  end
end