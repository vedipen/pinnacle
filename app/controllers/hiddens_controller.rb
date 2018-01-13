class HiddensController < ApplicationController
  before_action :find_hidden, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :same_user_or_admin_can_edit, only: [:edit, :update, :destroy]
  before_action :authenticate_user_owner, only: [:new, :create]

  def index
    @hiddens = Hidden.joins(:teamowner).order("team_name ASC")
  end

  def show
  end

  def new
    @hidden =  current_user.teamowner.hiddens.build
  end

  def create
    @hidden = current_user.teamowner.hiddens.build(hidden_params)

    if @hidden.save
      redirect_to @hidden
    else
      render 'new'
    end
  end

  def update
    if @hidden.update(hidden_params)
      redirect_to @hidden
    else
      render 'edit'
    end
  end

  def destroy
    @hidden.destroy
    redirect_to root_path
  end

  private

  def hidden_params
    params.require(:hidden).permit(:team_name, :event_name, :amount)
  end

  def find_hidden
    @hidden = Hidden.find(params[:id])
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
      if current_user.teamowner.hidden
        if current_user.teamowner.hidden.id == @hidden.id

        else
          redirect_to root_path
        end
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

end
