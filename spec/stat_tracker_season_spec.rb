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

  it "can find the biggest bust" do
    expect(@stat_tracker.biggest_bust("20132014")).to eq("Lightning")
    expect(@stat_tracker.biggest_bust("20142015")).to eq("Jets")
  end

  it "can find the biggest surprise" do
    expect(@stat_tracker.biggest_surprise("20132014")).to eq("Kings")
    expect(@stat_tracker.biggest_surprise("20142015")).to eq("Blackhawks")
  end
end
