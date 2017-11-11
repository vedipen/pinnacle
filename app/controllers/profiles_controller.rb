class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_user_participant_owner, only: [:new, :create, :update, :destroy]

  def index
    @profile = Profile.all.order("created_at DESC")
  end

  def show
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(post_params)

    if @profile.save
      redirect_to @profile
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @profile.update(post_params)
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

  def find_post
    @profile = Profile.find(params[:id])
  end

  def authenticate_user_participant_owner
    if current_user.usertype == "Participant" || current_user.usertype == "Owner"

    else
      redirect_to root_path
    end
  end

  def post_params
    params.require(:profile).permit(:about_me, :strengths, :weakness, :seniority, :age, :education, :nick_name)
  end

end
