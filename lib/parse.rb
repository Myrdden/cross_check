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
      teams[line[0]] = Team.new(line[0].to_i, self.hashify(keys, line[1..-1]))
    end
    return teams
  end

  def self.games_setup(teams, gamefile, statfile)
    @stats = IO.readlines(statfile).map {|x| split_words(x)}
    @keys = @stats.shift
    @stats = @stats.group_by {|line| line[0]}
    lines = IO.readlines(gamefile)
    gamesOut = []
    keys = self.split_words(lines.shift)
    lines.each do |line|
      line = self.split_words(line)
      gamesOut << self.hashify(keys, line)
      teams[line[4]].games << Game.new(line[0], line[5], line[7], self.getStats(line[0], line[4]))
      teams[line[5]].games << Game.new(line[0], line[4], line[6], self.getStats(line[0], line[5], true))
    end
    return gamesOut
  end

  def self.getStats(game, team, home = false)
    stat = home ? @stats[game][1] : @stats[game][0]
    return self.hashify(@keys, stat) if stat != nil
    return {}
  end

  def self.snake_case(key)
    key.gsub(/[[:upper:]]/) {|x| '_' + x.downcase}
  end

  def self.hashify(keysIn, valuesIn)
    out = {}
    keysIn.each_with_index do |x, i|
      out[self.snake_case(x).to_sym] = valuesIn[i]
    end
    return out
  end
end