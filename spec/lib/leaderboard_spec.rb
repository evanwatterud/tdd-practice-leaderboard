require 'spec_helper'

RSpec.describe Leaderboard do
  let(:leaderboard) { leaderboard = Leaderboard.new }

  describe ".new" do
    it "has an array of teams" do
      expect(leaderboard.teams).to be_kind_of(Array)
    end
    it "has teams with string names" do
      expect(leaderboard.teams.first.name).to be_kind_of(String)
    end
    it "has teams in order of rank" do
      leaderboard.teams.each_with_index do |team, index|
        expect(team.rank).to eq(index + 1)
      end
    end
  end

  describe "#display" do
    it "properly displays the leaderboard" do
      display = <<-eos
--------------------------------------------------
| Name      Rank      Total Wins    Total Losses |
| Patriots  1         3             0            |
| Steelers  2         1             1            |
| Broncos   3         1             2            |
| Colts     4         0             2            |
--------------------------------------------------
      eos
      expect{ leaderboard.display }.to output(display).to_stdout
    end
  end

  describe "#team_game_summary" do
    it "properly displays a summary of the teams games" do
      summary = <<-eos
Patriots played 3 games.
They played as the home team against the Broncos and won: 17 to 13.
They played as the home team against the Colts and won: 21 to 17.
They played as the away team against the Steelers and won: 31 to 24.
      eos
      expect{ leaderboard.team_game_summary(leaderboard.teams[0]) }.to output(summary).to_stdout
    end
  end
end
