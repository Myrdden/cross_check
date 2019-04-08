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
    <head><title>Hocky Sports Time Delux!!</title></head>
    <body>

      <h1>Hocky Sports Time Deluxe!!</h1>

      <p> Welcome to our hyper professional hockey stat page!

      We used the NHL stats from the 2012 - 2013 to to 2017 - 2018 seasons to
      generate our stats.

      </p>

      <ul>
          <li><b>This is the winningest team</b></li>
          <li><b> <%= @stat_tracker.winningest_team %> </b></li>
      </ul>

      </p>

    </body>
  </html>
}

rhtml = ERB.new(template)

stat_builder = StatBuilder.new

rhtml.run(stat_builder.get_binding)
