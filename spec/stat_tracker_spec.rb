require 'simplecov'
SimpleCov.start
require "./lib/stat_tracker"

describe StatTracker do

  before do
    game_path = './data/game.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_teams_stats.csv'

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
    expect(@stat_tracker.highest_total_score).to eq(7)
  end

  it "can find the lowest total score" do
    expect(@stat_tracker.lowest_total_score).to eq(3)
  end

  it "can find the biggest blowout" do
    expect(@stat_tracker.biggest_blowout).to eq(3)
  end

  it "can find the percentage of home wins" do
    expect(@stat_tracker.percentage_home_wins).to eq(80.0)
  end

  it "can find the percentage of visitor wins" do
    expect(@stat_tracker.percentage_visitor_wins).to eq(20.0)
  end

  it "can find the count of games by season" do
    expect(@stat_tracker.count_of_games_by_season).to eq({"20122013" => 5})
  end

  it "can find the average goals per game" do
    expect(@stat_tracker.average_goals_per_game).to eq(5.2)
  end

  it "can find the average goals by season" do
    expect(@stat_tracker.average_goals_per_game).to eq(5.2)
  end

end
