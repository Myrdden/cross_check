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

  it "finds the best season" do
    expect(@stat_tracker.best_season("6")).to eq(20122013)
  end

  it "finds the best season" do
    expect(@stat_tracker.worst_season("6")).to eq(20122013)
  end

  it "finds the average_win_percentage" do
    expect(@stat_tracker.average_win_percentage("6")).to eq(56.27)
  end

  it "finds most goals scored" do
    expect(@stat_tracker.most_goals_scored("18")).to eq(9)
  end

  it "finds fewest goals scored" do
    expect(@stat_tracker.fewest_goals_scored("18")).to eq(0)
  end
end
