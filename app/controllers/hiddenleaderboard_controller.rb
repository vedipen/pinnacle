class HiddenleaderboardController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_can_edit
  def index
    @flag=false
    @scores = Hash.new
    for i in Team.all
      for j in Scoreboard.all
        if i == j.team
          @scores[i.id] = ((@scores[i.id]).to_i + j.currentscore + 0).to_s
        end
      end
    end
    puts @scores
    for i in Hidden.all
      for j in Scoreboard.all
        if i.team == j.team && i.post == j.post
          @flag=false
          if j.team != i.teamowner.team
            for k in j.team.teamowner.anti_viri
              if k.post == j.post
                @flag=true
              end
            end
          end
          if @flag==false
            # iDHAR ANTIVIRUS NHI HAI
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
            @scores[i.teamowner.team.id] = ((@scores[i.teamowner.team.id]).to_i + (i.amount*@multiplier)).to_s
          end
        end
      end
    end
    puts @scores
    for i in Virus.all
      for j in Scoreboard.all
        if i.team == j.team && i.post == j.post
          @flag=false
          for k in j.team.teamowner.anti_viri
            if k.post == j.post
              @flag=true
            end
          end
          if @flag==false
            # iDHAR ANTIVIRUS NHI HAI
            @scores[i.teamowner.team.id] = ((@scores[i.teamowner.team.id]).to_i + (j.currentscore)).to_s
          end
        end
      end
    end
    puts @scores
  end

  private

  def admin_can_edit
    if current_user.usertype == "Admin"

    else
      redirect_to originalscoreboard_path
    end
  end

end
