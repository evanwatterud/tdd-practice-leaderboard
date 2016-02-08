require "pry"

class Leaderboard
  GAME_INFO = [
    {
      home_team: "Patriots",
      away_team: "Broncos",
      home_score: 17,
      away_score: 13
    },
    {
      home_team: "Broncos",
      away_team: "Colts",
      home_score: 24,
      away_score: 7
    },
    {
      home_team: "Patriots",
      away_team: "Colts",
      home_score: 21,
      away_score: 17
    },
    {
      home_team: "Broncos",
      away_team: "Steelers",
      home_score: 11,
      away_score: 27
    },
    {
      home_team: "Steelers",
      away_team: "Patriots",
      home_score: 24,
      away_score: 31
    }
  ]

  attr_reader :teams

  def initialize(game_data = GAME_INFO)
    teams = {}
    game_data.each do |game|
      teams[game[:home_team]] = Team.new(game[:home_team]) if teams[game[:home_team]].nil?
      teams[game[:away_team]] = Team.new(game[:away_team]) if teams[game[:away_team]].nil?
    end

    game_data.each do |game|
      if game[:home_score] > game[:away_score]
        teams[game[:home_team]].wins += 1
        teams[game[:away_team]].losses += 1
      else
        teams[game[:home_team]].losses += 1
        teams[game[:away_team]].wins += 1
      end
    end

    sorted_teams = teams.values.sort_by{ |team| team.losses }
    sorted_teams.each_with_index do |team, index|
      team.rank = index + 1
    end

    @teams = sorted_teams
  end

  def display
    puts "--------------------------------------------------"
    puts "| Name      Rank      Total Wins    Total Losses |"
    @teams.each do |team|
      puts "| #{team.name.ljust(10)}#{team.rank.to_s.ljust(10)}#{team.wins.to_s.ljust(14)}#{team.losses.to_s.ljust(12)} |"
    end
    puts "--------------------------------------------------"
  end

  def team_game_summary(team)
    puts "#{team.name} played #{team.wins + team.losses} games."
    GAME_INFO.each do |game|
      if game[:home_team] == team.name
        result = "lost"
        result = "won" if game[:home_score] > game[:away_score]
        puts "They played as the home team against the #{game[:away_team]} and #{result}: #{game[:home_score]} to #{game[:away_score]}."
      elsif game[:away_team] == team.name
        result = "lost"
        result = "won" if game[:away_score] > game[:home_score]
        puts "They played as the away team against the #{game[:home_team]} and #{result}: #{game[:away_score]} to #{game[:home_score]}."
      end
    end
  end

end
