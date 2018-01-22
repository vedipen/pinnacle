class ScoreboardsController < ApplicationController
  before_action :find_scoreboard, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new]
  before_action :admin_can_edit, only: [:edit, :update, :destroy, :new]

  def index
    @scoreboards = Scoreboard.joins(:team).order("created_at DESC")

  end

  def show
  end

  def new
    @scoreboards = Scoreboard.joins(:team).order("created_at DESC")
    @scoreboard =  Scoreboard.new
  end

  def edit
  end

  def create
    @scoreboard = Scoreboard.new(scoreboard_params)
    @scoreboard.save
    redirect_to scoreboards_path
  end

  def update
    tempupdate = scoreboard_params
    @eventdone = Post.find(tempupdate[:post_id])
    @scoreadded = tempupdate[:currentscore]

    if @scoreboard.update(scoreboard_params)
      redirect_to scoreboards_path
    else
      redirect_to edit_scoreboard_path(@scoreboard)
    end
  end

  def destroy
    @scoreboard.destroy
    redirect_to scoreboards_path
  end

  private

  def scoreboard_params
    params.require(:scoreboard).permit(:team_id, :currentscore, :post_id)
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
