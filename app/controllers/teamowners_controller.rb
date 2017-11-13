class TeamownersController < ApplicationController
  before_action :find_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_user_owner, only: [:new, :create]
  before_action :already_created_profile, only: [:create, :new]
  before_action :same_user_or_admin_can_edit, only: [:edit, :update, :destroy]

  def index
    @ownerprofile = Teamowner.all.order("created_at DESC")
  end

  def show
    @user = current_user
    @random_owner = Teamowner.where.not(id: @ownerprofile).order("RANDOM()").first
  end

  def new
    @ownerprofile =  current_user.build_teamowner
  end

  def create
    @ownerprofile = current_user.build_teamowner(owner_params)

    if @ownerprofile.save!
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @ownerprofile.update(owner_params)
      redirect_to @ownerprofile
    else
      render 'edit'
    end
  end

  def destroy
    @ownerprofile.destroy
    redirect_to root_path
  end

  private

  def find_profile
    @ownerprofile = Teamowner.find(params[:id])
  end

  def authenticate_user_owner
    if current_user.usertype == "Owner"

    else
      redirect_to root_path
    end
  end

  def profile_params
    params.require(:teamowner).permit(:aboutme, :seniority, :age, :education, :nick_name, :room, :phone)
  end

  def already_created_profile
    if current_user.teamowner == nil

    else
      redirect_to profile_path(current_user.profile.id)
    end
  end

  def same_user_or_admin_can_edit
    if current_user.usertype == "PMC" || current_user.usertype == "Admin"

    elsif current_user.teamowner
      if current_user.teamowner.id == @ownerprofile.id

      else
        redirect_to teamowner_path(@ownerprofile.id)
      end
    else
      redirect_to teamowner_path(@ownerprofile.id)
    end
  end

end
