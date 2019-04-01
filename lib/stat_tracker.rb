class StatTracker
  extend Recursive
  def initialize(locations)
    parser = ParseCSV.new if locations.values.all? {|x| File.extname(x) == ".csv"}
    @games = parser.parse(locations[:games])
    @total_scores = nil
    @teams = parser.parse(locations[:teams])
    @stats = parser.parse(locations[:stats])
  end

  rec def get_total_score(inp, out) #::[Games] -> [Total Scores]
    return out if inp.empty?
    x, *xs = inp
    out << x[:home_goals] + x[:away_goals]
    get_total_score(xs, out)
  end

  def highest_total_score
    if !@total_scores.defined?
      @total_scores = get_total_score(@games, [])
    end
    return @total_scores.max
  end

  def lowest_total_score
    if !@total_scores.defined?
      @total_scores = get_total_score(@games, [])
    end
    return @total_scores.min
  end

  def biggest_blowout

  end

  def percentage_home_wins

  end

  def percentage_visitor_wins
  end

  def count_of_games_by_season
  end

  def average_goals_per_game
  end

  def average_goals_by_season
  end
end