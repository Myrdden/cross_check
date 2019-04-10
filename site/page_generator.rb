require "erb"
require "./lib/stat_tracker"


class StatBuilder
  def initialize
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

  def get_binding
    binding
  end

  def season_parcer(seasons)
    acc = ""
    seasons.each do |season|
      acc += "#{season.dup.insert(4, "-")} <br />"
    end
    return acc
  end

  def goal_parser
    acc = ""
    @stat_tracker.average_goals_by_season.each_value do |v|
      acc += "#{v} goals <br />"
    end
    return acc
  end

end

template = %{
  <html>
    <head>
    <link rel="stylesheet" type="text/css" href="index.css">
    <title>Super Hockey Sports Time Deluxe!!</title></head>
    <body>
      <div id="text">
      <h1 class="title">Super Hockey Sports Time Deluxe!!</h1>

      <p class="readable"> Welcome to our hyper professional hockey stat page, eh!</p>

      <p class="readable"> We used the NHL stats from the 2012 - 2013 to 2017 - 2018 seasons to
      generate our stats.</p>

      <hr />

      <h2 class="readable">General Stats</h2>

      <hr />

      <table class="readable">
        <tbody>
        <tr>
        <td>The highest total scoring game on record had:</td>
        <td><%= @stat_tracker.highest_total_score %> goals</td>
        </tr>
        <tr>
        <td>The lowest total scoring game on record had:</td>
        <td><%= @stat_tracker.lowest_total_score %> goals</td>
        </tr>
        <tr>
        <td>The biggest blowout was by:</td>
        <td><%= @stat_tracker.biggest_blowout %> goals</td>
        </tr>
        <tr>
        <td>The overall percentage of home team wins was:</td>
        <td><%= (@stat_tracker.percentage_home_wins * 100).round  %> % </td>
        </tr>
        <tr>
        <td>The overall percentage of visitor team wins was:</td>
        <td><%= (@stat_tracker.percentage_visitor_wins * 100).round %> %</td>
        </tr>
        <tr>
        <td>The overall average goals scored per game was:</td>
        <td><%= @stat_tracker.average_goals_per_game %> goals </td>
        </tr>
        <tr>
        <td>The average goals scored per game by season were:<br />
        <%= self.season_parcer(@stat_tracker.average_goals_by_season.keys) %></td>
        <td><br /><%= self.goal_parser%></td>
        </tr>
        <tr>
        <td>Total teams in the league:</td>
        <td><%= @stat_tracker.count_of_teams %></td>
        </tr>
        <tr>
        <td>The team with the best overall offense is:</td>
        <td><%= @stat_tracker.best_offense %></td>
        </tr>
        <tr>
        <td>The team with the worst overall offense is:</td>
        <td><%= @stat_tracker.worst_offense %></td>
        </tr>
        <tr>
        <td>The team with the best overall defence is:</td>
        <td><%= @stat_tracker.best_defense %></li></td>
        </tr>
        <tr>
        <td>The team with the worst overall defence is:</td>
        <td><%= @stat_tracker.worst_defense %></td>
        </tr>
        <tr>
        <td>The team with the highest average score per game as
        a visiting team is:</td>
        <td><%= @stat_tracker.highest_scoring_visitor %></td>
        </tr>
        <tr>
        <td>The team with the highest average score per game as
        the home team is:</td>
        <td> <%= @stat_tracker.highest_scoring_home_team %></td>
        </tr>
        <tr>
        <td>The team with the highest win percentage overall is</td>
        <td><%= @stat_tracker.winningest_team %></td>
        </tr>
        <tr>
        <td>The team with the best fans (biggest difference in home team
        wins vs. away team wins) is:</td>
        <td><%= @stat_tracker.best_fans %></td>
        </tr>
        </tbody>
      </table>

      <h2 class="readable">Team Stats</h2>

      <hr />

      <img src="http://i.ebayimg.com/images/i/180730518769-0-1/s-l1000.jpg"
      alt="People read this?">
      </div>
    </body>
  </html>
}


#can't call methods in a string. can call ivars
rhtml = ERB.new(template)

stat_builder = StatBuilder.new
# stat_builder.test

File.open("./site/index.html", "w+") do |f|
  f.write rhtml.result(stat_builder.get_binding)
end
