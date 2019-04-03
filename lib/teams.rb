require './lib/games'

module MemoTeam
  def memo(name)
    fn = instance_method(name)
    @@team_stats = Hash.new{|k,v| k[v] = {}} if !defined? @@team_stats

    define_method(name) do |team|
      team_ID = team.to_sym
      if !@@team_stats.has_key?(name)
        @@team_stats[name] = {}
      end
      if !@@team_stats[name].has_key?(team_ID)
        @@team_stats[name][team_ID] = fn.bind(self).call(team)
      end
      return @@team_stats[name][team_ID]
    end
  end
end

class Teams
  extend MemoTeam
  def initialize(teams)
    @teams = teams
  end

  def [](teamID); return @teams[teamID] end

  def team_info(team)
    return {"team_id" => @teams[team].id.to_s}.merge(@teams[team].stats.transform_keys(&:to_s))
  end

  def season_inator(gameID)
    return gameID[0..3] + (gameID[0..3].to_i + 1).to_s
  end

  memo def best_season(team)
    total_games = []
    @teams[team].games.each do |game|
      total_games << season_inator(game.id).to_i if game.won?
    end
    temp = total_games.group_by {|x| x}.max_by(&:size)
    return temp[0]
  end

  memo def worst_season(team)
    total_games = []
    @teams[team].games.each do |game|
      total_games << season_inator(game.id).to_i if game.won?
    end
    temp = total_games.group_by {|x| x}.min_by(&:size)
    return temp[0]
  end

  memo def average_win_percentage(team)
    total_games = @teams[team].games.count
    won_games = @teams[team].games.count {|game| game.won?}
    return (won_games / total_games.to_f).round(2)
  end

  memo def most_goals_scored(team)
    return @teams[team].games.max_by {|stat| stat[:goals].to_i}[:goals].to_i
  end

  memo def fewest_goals_scored(team)
    return @teams[team].games.min_by {|stat| stat[:goals].to_i}[:goals].to_i
  end

  memo def favorite_opponent(team)
    temp = @teams[team].win_percentages.max_by {|_,v| v}
    return @teams[temp[0]][:team_name]
  end

  memo def rival(team)
    temp = @teams[team].win_percentages.min_by {|_,v| v}
    return @teams[temp[0]][:team_name]
  end

  memo def biggest_team_blowout(team); return @teams[team].win_ratios.max.abs end

  memo def worst_loss(team); return @teams[team].win_ratios.min.abs end

  def head_to_head(team)
    return @teams[team].win_percentages.transform_keys {|k| @teams[k][:team_name]}
  end

  memo def seasonal_summary(team)
    output = {}
    seasons = @teams[team].games.group_by {|x| x.season}
    seasons.map do |season, game|
      temp = games.group_by {|x| x.game_type}
      p season
      output[season] = {}
      output[season][:regular_season] = season_stats(temp["R"])
      output[season][:postseason] = season_stats(temp["P"])
    end
    p output
    return output
  end

  def season_stats(games)
    p Team.win_ratios(games)
  end
end
