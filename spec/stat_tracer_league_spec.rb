require "./spec/spec_helper"
require "./lib/stat_tracker"

describe StatTracker do

  before(:all) do
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

  it "finds the count of teams" do
    expect(@stat_tracker.count_of_teams).to eq 32
  end

  it "finds the best offense" do
    expect(@stat_tracker.best_offense).to eq "Golden Knights"
  end

  it "finds the worst offense" do
    expect(@stat_tracker.worst_offense).to eq "Sabres"
  end

  it "finds the best defense" do
    expect(@stat_tracker.best_defense).to eq "Kings"
  end

  it "finds the worst defense" do
    expect(@stat_tracker.worst_defense).to eq "Coyotes"
  end

  it "finds the highest scoring visitor" do
    expect(@stat_tracker.highest_scoring_visitor).to eq "Capitals"
  end

  it "finds the highest scoring home team" do
    expect(@stat_tracker.highest_scoring_home_team).to eq "Golden Knights"
  end

  it "finds the lowest scoring visitor" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq "Sabres"
  end

  it "finds the lowest scoring home team" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq "Sabres"
  end

  it "finds the winningest team" do
    expect(@stat_tracker.winningest_team).to eq "Golden Knights"
  end

  it "finds the best fans" do
    expect(@stat_tracker.best_fans).to eq "Coyotes"
  end

  it "finds the worst fans" do
    expect(@stat_tracker.worst_fans).to eq []
  end
end
