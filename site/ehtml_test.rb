require "erb"
require "./lib/stat_tracker"


class StatBuilder
  def initialize
    game_path = '../cross_check_spec_harness/data/game.csv'
    team_path = '../cross_check_spec_harness/data/team_info.csv'
    game_teams_path = '../cross_check_spec_harness/data/game_teams_stats.csv'

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
end

template = %{
  <html>
    <head><title>Super Hocky Sports Time Deluxe!!</title></head>
    <body>

      <h1>Super Hocky Sports Time Deluxe!!</h1>

      <p> Welcome to our hyper professional hockey stat page, eh!</p>

      <p> We used the NHL stats from the 2012 - 2013 to to 2017 - 2018 seasons to
      generate our stats.</p>

      <ul>
          <li>The highest total scoring game on record had
          <%= @stat_tracker.highest_total_score %> goals.</li>
          <li>The lowest total scoring game on record had
          <%= @stat_tracker.lowest_total_score %> goals.</li>
          <li>The biggest blowout was by <%= @stat_tracker.biggest_blowout %>
          goals.</li>
          <li>The percentage of home team wins was
          <%= @stat_tracker.percentage_home_wins %> overall.</li>
          <li>The percentage of visitor team wins was
          <%= @stat_tracker.percentage_visitor_wins %> overall.</li>
          <li>The average goals scored per game was
          <%= @stat_tracker.average_goals_per_game %> overall.</li>
          <li>The average goals scored per game by season were:
          <%= @stat_tracker.average_goals_by_season %>.</li>
          <li>There are <%= @stat_tracker.count_of_teams %> teams in the league </li>
          <li>The team with the best overall offense is
          <%= @stat_tracker.best_offense %></li>
          <li>The team with the worst overall offense is
          <%= @stat_tracker.worst_offense %></li>
          <li>The team with the best overall defence is
          <%= @stat_tracker.best_defense %></li>
          <li>The team with the worst overall defence is
          <%= @stat_tracker.worst_defense %></li>
          <li>The team with the highest average score per game as
          a visiting team is <%= @stat_tracker.highest_scoring_visitor %></li>
          <li>The team with the highest average score per game as
          the home team is <%= @stat_tracker.highest_scoring_home_team %></li>
          <li>The team with the highest win percentage overall is
          <%= @stat_tracker.highest_winningest_team %></li>
          <li>The team with the best fans is
          <%= @stat_tracker.highest_best_fans %></li>
      </ul>

      </p>

    </body>
  </html>
}

rhtml = ERB.new(template)

stat_builder = StatBuilder.new

rhtml.run(stat_builder.get_binding)
