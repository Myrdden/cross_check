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

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it "exists" do
    expect(@stat_tracker).to be_a(StatTracker)
  end
end
