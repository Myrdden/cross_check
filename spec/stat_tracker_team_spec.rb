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

  it "finds the best season" do
    expect(@stat_tracker.best_season("6")).to eq(20122013)
  end

  it "finds the best season" do
    expect(@stat_tracker.worst_season("6")).to eq(20122013)
  end

  it "finds the average_win_percentage" do
    expect(@stat_tracker.average_win_percentage("6")).to eq(0.52)
  end

  it "finds most goals scored" do
    expect(@stat_tracker.most_goals_scored("18")).to eq(9)
  end

  it "finds fewest goals scored" do
    expect(@stat_tracker.fewest_goals_scored("18")).to eq(0)
  end

  it "finds the favourite opponent" do
    expect(@stat_tracker.favorite_opponent("18")).to eq "Oilers"
  end

  it "finds the greatest rival" do
    expect(@stat_tracker.rival("18")).to eq "Red Wings"
  end

  it "finds the biggest team blowout" do
    expect(@stat_tracker.biggest_team_blowout("18")).to eq 7
  end

  it "finds the worst loss" do
    expect(@stat_tracker.worst_loss("18")).to eq 6
  end

  it "finds the win/loss record against all opponents" do
    expected = {
      "Blues" => 0.47,
      "Jets" => 0.55,
      "Avalanche" => 0.63,
      "Flames" => 0.44,
      "Red Wings" => 0.29,
      "Blue Jackets" => 0.6,
      "Stars" => 0.52,
      "Blackhawks" => 0.42,
      "Wild" => 0.44,
      "Devils" => 0.5,
      "Canadiens" => 0.6,
      "Canucks" => 0.5,
      "Rangers" => 0.4,
      "Lightning" => 0.7,
      "Capitals" => 0.7,
      "Sharks" => 0.6,
      "Oilers" => 0.78,
      "Ducks" => 0.48,
      "Penguins" => 0.31,
      "Islanders" => 0.4,
      "Kings" => 0.61,
      "Sabres" => 0.7,
      "Coyotes" => 0.67,
      "Bruins" => 0.5,
      "Panthers" => 0.5,
      "Maple Leafs" => 0.4,
      "Senators" => 0.7,
      "Hurricanes" => 0.3,
      "Golden Knights" => 0.33,
      "Flyers" => 0.5
    }

    expect(@stat_tracker.head_to_head("18")).to eq expected
  end

  it "provides a seasonal summary for a team" do
    expected = {
      "20162017" => {
        postseason: {
          :win_percentage=>0.64,
          :total_goals_scored=>60,
          :total_goals_against=>48,
          :average_goals_scored=>2.73,
          :average_goals_against=>2.18},
          :regular_season => {
            :win_percentage=>0.5,
            :total_goals_scored=>240,
            :total_goals_against=>224,
            :average_goals_scored=>2.93,
            :average_goals_against=>2.73
          }
        },
        "20172018" => {
          postseason: {
            :win_percentage=>0.54,
            :total_goals_scored=>41,
            :total_goals_against=>42,
            :average_goals_scored=>3.15,
            :average_goals_against=>3.23
          },
          :regular_season=>
          {:win_percentage=>0.65,
            :total_goals_scored=>267,
            :total_goals_against=>211,
            :average_goals_scored=>3.26,
            :average_goals_against=>2.57
          }
        },
        "20132014" => {
          postseason: {
            :win_percentage=>0.0,
            :total_goals_scored=>0,
            :total_goals_against=>0,
            :average_goals_scored=>0.0,
            :average_goals_against=>0.0
          },
          :regular_season=>
          {
            :win_percentage=>0.46,
            :total_goals_scored=>216,
            :total_goals_against=>242,
            :average_goals_scored=>2.63,
            :average_goals_against=>2.95
          }
        },
        "20122013" => {
          postseason: {
            :win_percentage=>0.0,
            :total_goals_scored=>0,
            :total_goals_against=>0,
            :average_goals_scored=>0.0,
            :average_goals_against=>0.0
          },
          :regular_season=>
          {
            :win_percentage=>0.33,
            :total_goals_scored=>111,
            :total_goals_against=>139,
            :average_goals_scored=>2.31,
            :average_goals_against=>2.9
          }
        },
        "20142015" => {
          postseason: {
            :win_percentage=>0.33,
            :total_goals_scored=>21,
            :total_goals_against=>19,
            :average_goals_scored=>3.5,
            :average_goals_against=>3.17
          },
          :regular_season=>
          {
            :win_percentage=>0.57,
            :total_goals_scored=>232,
            :total_goals_against=>208,
            :average_goals_scored=>2.83,
            :average_goals_against=>2.54
          }
        },
        "20152016" => {
          postseason: {
            :win_percentage=>0.5,
            :total_goals_scored=>31,
            :total_goals_against=>43,
            :average_goals_scored=>2.21,
            :average_goals_against=>3.07
          },
          :regular_season=>
          {
            :win_percentage=>0.5,
            :total_goals_scored=>228,
            :total_goals_against=>215,
            :average_goals_scored=>2.78,
            :average_goals_against=>2.62
          }
        }
      }
      expect(@stat_tracker.seasonal_summary("18")).to eq expected
    end
end
