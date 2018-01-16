class LeaderboardController < ApplicationController
  def index
    @scores = Hash.new
    for i in Team.all
      for j in Scoreboard.all
        if i == j.team
          @scores[i.id]= ((@scores[i.id]).to_i + j.currentscore + 0).to_s
        end
      end
    end
  end

  def betting
    @bets = Hash.new
    @multiplier = 0
    for i in Bet.all
      for j in Scoreboard.all
        @multiplier = 0
        if j.currentscore == 25
          @multiplier = 1
        elsif j.currentscore == 50
          @multiplier = 2
        elsif j.currentscore == 75
          @multiplier = 3
        elsif j.currentscore == 100
          @multiplier = 4
        end
        if i.team == j.team && i.post == j.post
          @bets[i.user.id] = ((@bets[i.user.id]).to_i + (@multiplier*10) + 0).to_s
        end
      end
    end
  end
end
