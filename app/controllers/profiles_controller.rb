class ProfilesController < ApplicationController
  before_action :find_profile, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_user_participant_owner, only: [:new, :create]
  before_action :already_created_profile, only: [:create, :new]
  before_action :same_user_or_admin_can_edit, only: [:edit, :update, :destroy]

  def index
    @profiles = Profile.all.order("created_at DESC")
  end

  def show
    @user = current_user
    @random_participant = Profile.where.not(id: @post).order("RANDOM()").first
  end

  def new
    @profile =  current_user.build_profile
  end

  def create
    @profile = current_user.build_profile(profile_params)

    if @profile.save!
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
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

  def authenticate_user_participant_owner
    if current_user.usertype == "Participant" || current_user.usertype == "Owner"

    else
      redirect_to root_path
    end
  end

  def profile_params
    params.require(:profile).permit(:about_me, :strengths, :weakness, :seniority, :age, :education, :nick_name)
  end

  def already_created_profile
    if current_user.profile == nil

    else
      redirect_to profile_path(current_user.profile.id)
    end
  end

  def same_user_or_admin_can_edit
    if current_user.usertype == "PMC" || current_user.usertype == "Admin"

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
