class PmcmembersController < ApplicationController
  before_action :find_pmcprofile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_user_pmc, only: [:new, :create]
  before_action :already_created_profile, only: [:create, :new]
  before_action :same_user_or_admin_can_edit, only: [:edit, :update, :destroy]

  def index
    @pmcprofile = Pmcmember.joins(:user).order("name ASC")

  end

  def show
    @user = current_user
    @random_pmc = Pmcmember.where.not(id: @pmcprofile).order("RANDOM()").first
  end

  def new
    @pmcprofile =  current_user.build_pmcmember
  end

  def create
    @pmcprofile = current_user.build_pmcmember(pmc_params)

    if @pmcprofile.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @pmcprofile.update(pmc_params)
      redirect_to @pmcprofile
    else
      render 'edit'
    end
  end

  def destroy
    @pmcprofile.destroy
    redirect_to root_path
  end

  private

  def find_pmcprofile
    @pmcprofile = Pmcmember.find(params[:id])
  end

  def authenticate_user_pmc
    if current_user.usertype == "PMC"

    else
      redirect_to root_path
    end
  end

  def pmc_params
    params.require(:pmcmember).permit(:aboutme, :seniority, :age, :education, :nick_name, :room, :phone, :image)
  end

  def already_created_profile
    if current_user.pmcmember == nil

    else
      redirect_to pmcmember_path(current_user.pmcmember.id)
    end
  end

  def same_user_or_admin_can_edit
    if current_user.usertype == "Admin"

    elsif current_user.pmcmember
      if current_user.pmcmember.id == @pmcprofile.id

      else
        redirect_to pmcmember_path(@pmcprofile.id)
      end
    else
      redirect_to pmcmember_path(@pmcprofile.id)
    end
  end

end
