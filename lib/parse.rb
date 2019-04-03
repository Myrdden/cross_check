require './lib/game'
require './lib/team'

class ParseCSV
  def self.split_words(line)
    return line.chomp.split(/,/).map {|x| x[0] == "\"" ? x[1..-2] : x}
  end

  def self.teams_setup(teamfile)
    lines= IO.readlines(teamfile)
    teams = {}
    keys = self.split_words(lines.shift)[1..-1]
    lines.each do |line|
      line = self.split_words(line)
      teams[line[0].to_sym] = Team.new(line[0].to_i, self.hashify(keys, line[1..-1]))
    end
    return teams
  end

  def self.games_setup(teams, gamefile, statfile)
    @stats = IO.readlines(statfile).map {|x| split_words(x)}
    @keys = @stats.shift
    lines = IO.readlines(gamefile)
    gamesOut = []
    keys = self.split_words(lines.shift)
    lines.each do |line|
      line = self.split_words(line)
      gamesOut << self.hashify(keys, line)
      p line[4].to_sym
      teams[line[4].to_sym].games << Game.new(line[4], line[5], self.getStats(line[0], line[4]))
      teams[line[5].to_sym].games << Game.new(line[5], line[4], self.getStats(line[0], line[5]))
    end
    return gamesOut
  end

  def self.getStats(game, team)
    stat = @stats.find {|x| x[0] == game && x[1] == team}
    return self.hashify(@keys, stat) if stat != nil
    return {}
  end

  def self.hashify(keysIn, valuesIn)
    out = keysIn.inject({}) do |key, ele|
      p key
      key[ele] = valuesIn[keysIn.find_index(ele)]
      key
    end
    return out
  end
end