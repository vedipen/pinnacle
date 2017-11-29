class TeamsController < ApplicationController
  before_action :find_team, only: [:show, :edit, :update, :destroy, :addteam]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :already_created_team, only: [:create, :new]
  before_action :same_user_or_admin_can_edit, only: [:edit, :update, :destroy]
  before_action :authenticate_user_owner, only: [:new, :create]
  before_action :only_admin, only: [:addteam]

  def index
    @teams = Team.joins(:teamowner).order("name ASC")
  end

  def show
    @random_team = Team.where.not(id: @team).order("RANDOM()").first
  end

  def new
    @team =  current_user.teamowner.build_team
  end

  def create
    @team = current_user.teamowner.build_team(team_params)

    if @team.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    if @team.update(team_params)
      redirect_to @team
    else
      render 'edit'
    end
  end

  def destroy
    @team.destroy
    redirect_to root_path
  end

  def addteam
    @profiles = Profile.joins(:user).order("name ASC")
  end

  private

  def team_params
    params.require(:team).permit(:about_team, :name)
  end

  def find_team
    @team = Team.find(params[:id])
  end

  def already_created_team
    if current_user.teamowner
      if current_user.teamowner.team == nil

      else
        redirect_to team_path(current_user.teamowner.team.id)
      end
    else
      redirect_to root_path
    end
  end

  def authenticate_user_owner
    if current_user.usertype == "Owner"

    else
      redirect_to root_path
    end
  end

  def same_user_or_admin_can_edit
    if current_user.usertype == "Admin"

    elsif current_user.teamowner
      if current_user.teamowner.team
        if current_user.teamowner.team.id == @team.id

        else
          redirect_to team_path(@team.id)
        end
      else
        redirect_to team_path(@team.id)
      end
    else
      redirect_to team_path(@team.id)
    end
  end

  def only_admin
    if current_user
      if current_user.usertype == "Admin"

      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

end
