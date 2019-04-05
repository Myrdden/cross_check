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
      gameDataA = [line[0], line[5], line[7], line[6], line[1], line[2], \
        self.getStats(line[0], line[4])]
      gameDataB = [line[0], line[4], line[6], line[7], line[1], line[2], \
        self.getStats(line[0], line[5], true)]
      gameA = Game.new(gameDataA)
      gameB = Game.new(gameDataB)
      teams[line[4]].games << gameA
      teams[line[4]].games_by_season[gameA.season] ||= []
      teams[line[4]].games_by_season[gameA.season] << gameA
      teams[line[5]].games << gameB
      teams[line[5]].games_by_season[gameB.season] ||= []
      teams[line[5]].games_by_season[gameB.season] << gameB
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
