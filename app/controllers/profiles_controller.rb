class ProfilesController < ApplicationController
  before_action :find_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_user_participant, only: [:new, :create]
  before_action :already_created_profile, only: [:create, :new]
  before_action :same_user_or_admin_can_edit, only: [:edit, :update, :destroy]

  def index
    @profiles = Profile.all.order("created_at DESC")
    # @profiles = Profile.joins(:user).order("name ASC")
  end

  def show
    @user = current_user
    @random_participant = Profile.where.not(id: @profile).order("RANDOM()").first
    @teams = Team.all
  end

  def new
    @profile =  current_user.build_profile
  end

  def create
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:profile][:source].to_s == "change_team"
      params[:profile].delete(:source)
      allowed_params = admin_profile_params
    else
      allowed_params = profile_params
    end
    if @profile.update(allowed_params)
      redirect_to @profile
    else
      render 'edit'
    end
  end

  def destroy
    @profile.destroy
    redirect_to root_path
  end

  private

  def find_profile
    @profile = Profile.find(params[:id])
  end

  def authenticate_user_participant
    if current_user.usertype == "Participant"

    else
      redirect_to root_path
    end
  end

  def profile_params
    params.require(:profile).permit(:about_me, :strengths, :weakness, :seniority, :age, :education, :nick_name, :image, :room, :phone, :availability)
  end

  def admin_profile_params
    params.require(:profile).permit(:team_id)
  end

  def already_created_profile
    if current_user.profile == nil

    else
      redirect_to profile_path(current_user.profile.id)
    end
  end

  def same_user_or_admin_can_edit
    if current_user.usertype == "Admin"

    elsif current_user.profile
      if current_user.profile.id == @profile.id

      else
        redirect_to profile_path(@profile.id)
      end
    else
      redirect_to profile_path(@profile.id)
    end
  end

end
