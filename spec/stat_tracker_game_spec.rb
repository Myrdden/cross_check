require 'simplecov'
SimpleCov.start
require "./lib/stat_tracker"

describe StatTracker do

  before do
    game_path = '../cross_check_spec_harness/data/game.csv'
    team_path = '../cross_check_spec_harness/data/team_info.csv'
    game_teams_path = '../cross_check_spec_harness/data/game_teams_stats.csv'

    # game_path = './data/game.csv'
    # team_path = './data/team_info.csv'
    # game_teams_path = './data/game_teams_stats.csv'

    locations = {
      games: game_path,
      teams: team_path,
      stats: game_teams_path
    }

    @stat_tracker = StatTracker.new(locations)
  end

  it "exists" do
    expect(@stat_tracker).to be_a(StatTracker)
  end

  it "can find the highest total score" do
    expect(@stat_tracker.highest_total_score).to eq(15)
  end

  it "can find the lowest total score" do
    expect(@stat_tracker.lowest_total_score).to eq(1)
  end

  it "can find the biggest blowout" do
    expect(@stat_tracker.biggest_blowout).to eq(10)
  end

  it "can find the percentage of home wins" do
    expect(@stat_tracker.percentage_home_wins).to eq(54.95)
  end

  it "can find the percentage of visitor wins" do
    expect(@stat_tracker.percentage_visitor_wins).to eq(45.05) # check with instructor
  end

  it "can find the count of games by season" do
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    expect(@stat_tracker.count_of_games_by_season).to eq(expected)
  end

  it "can find the average goals per game" do
    expect(@stat_tracker.average_goals_per_game).to eq(5.54)
  end

  it "can find the average goals by season" do
    expected = {
      "20122013"=>5.4,
      "20162017"=>5.51,
      "20142015"=>5.43,
      "20152016"=>5.41,
      "20132014"=>5.5,
      "20172018"=>5.94
    }
    expect(@stat_tracker.average_goals_by_season).to eq(expected)
  end

end
