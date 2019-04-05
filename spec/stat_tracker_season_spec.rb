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

  it "can find winningest coach" do
    expect(@stat_tracker.winningest_coach("20132014")).to eq("Claude Julien")
    #expect(@stat_tracker.winningest_coach("20142015")).to eq("Alain Vigneault")
  end

  it "can find worst coach" do
    expect(@stat_tracker.worst_coach("20132014")).to eq("Peter Laviolette")
    expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish")
  end

  it "can find most accurate team" do
    expect(@stat_tracker.most_accurate_team("20132014")).to eq "Ducks"
    expect(@stat_tracker.most_accurate_team("20142015")).to eq "Flames"
  end

  it "can find least accurate team" do
    expect(@stat_tracker.least_accurate_team("20132014")).to eq "Sabres"
    expect(@stat_tracker.least_accurate_team("20142015")).to eq "Coyotes"
  end

  it "can find most hits" do
    expect(@stat_tracker.most_hits("20132014")).to eq "Kings"
    expect(@stat_tracker.most_hits("20142015")).to eq "Islanders"
  end

  it "can find fewest hits" do
    expect(@stat_tracker.fewest_hits("20132014")).to eq "Devils"
    expect(@stat_tracker.fewest_hits("20142015")).to eq "Wild"
  end

  it "can find powerplay percentage" do
    expect(@stat_tracker.power_play_goal_percentage("20132014")).to eq 0.22
    expect(@stat_tracker.power_play_goal_percentage("20142015")).to eq 0.21
  end
end
