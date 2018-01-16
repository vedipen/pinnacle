class ScoreboardsController < ApplicationController
  before_action :find_scoreboard, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new]
  before_action :admin_can_edit, only: [:edit, :update, :destroy, :new]

  def index
    @scoreboards = Scoreboard.joins(:team).order("name ASC")

  end

  def show
  end

  def new
    @scoreboards = Scoreboard.joins(:team).order("name ASC")
    @scoreboard =  Scoreboard.new
  end

  def edit
  end

  def create
    @scoreboard = Scoreboard.new(scoreboard_params)
    if Team.find(scoreboard_params[:team_id]).scoreboard != nil
      flash[:alert] = "Team is already on scoreboard."
      redirect_to new_scoreboard_path
    else
      @scoreboard.save
      redirect_to scoreboards_path
    end
  end

  def update
    tempupdate = scoreboard_params
    @multiplier = 0
    if tempupdate[:currentscore] == 25
      @multiplier = 1
    elsif tempupdate[:currentscore] == 50
      @multiplier = 2
    elsif tempupdate[:currentscore] == 75
      @multiplier = 3
    elsif tempupdate[:currentscore] == 100
      @multiplier = 4
    end
    @scoreadded = tempupdate[:currentscore]

    tempupdate[:currentscore] = (scoreboard_params[:currentscore].to_i + Team.find(scoreboard_params[:team_id]).scoreboard.currentscore).to_s
    if @scoreboard.update(tempupdate)
      redirect_to scoreboards_path
    else
      redirect_to edit_scoreboard_path(@scoreboard)
    end
  end

  def destroy
    @scoreboard.destroy
    redirect_to root_path
  end

  private

  def scoreboard_params
    params.require(:scoreboard).permit(:team_id, :currentscore)
  end

  def find_scoreboard
    @scoreboard = Scoreboard.find(params[:id])
  end

  def admin_can_edit
    if current_user.usertype == "Admin"

    else
      redirect_to scoreboards_path
    end
  end

end
