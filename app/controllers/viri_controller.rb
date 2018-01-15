class ViriController < ApplicationController
  before_action :find_virus, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :same_user_or_admin_can_edit, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user_owner

  def index
    @viri = Virus.joins(:teamowner).order("team_id ASC")
  end

  def show
  end

  def new
    @viri = Virus.joins(:teamowner).order("team_id ASC")
    @virus =  current_user.teamowner.viri.build
    @tempp = Post.where(events: true, hidden_transactions: true)
    if @tempp.size==0 || current_user.teamowner.hidden_virus < 1
      flash[:alert] = "No event or virus available for transaction."
      redirect_to viri_path
    end
  end

  def create
    @virus = current_user.teamowner.viri.build(virus_params)
    if @virus
      @sum=0
      @flag=false
      for i in @virus.teamowner.viri
        @sum+=1
        if i.post==@virus.post && i.team==@virus.team
          @flag=true
        end
      end
      if @flag==true
        flash[:alert] = "Event " + @virus.post.title + " already has your virus for team " + @virus.team.name + "."
        redirect_to new_virus_path
      else
        @sum+=1
        if @sum>2 || current_user.teamowner.hidden_virus<1
          flash[:alert] = "No viruses left."
          redirect_to new_virus_path
        else
          @virus.save
          flash[:notice] = "Virus successfully loaded. Please keep this confidential. PMC is not responsible for any leaks. A transaction can't be deleted or edited once it is done. Contact PMC if any doubts."
          current_user.teamowner.hidden_virus-=1
          current_user.teamowner.save
          redirect_to viri_path
        end
      end
    else
      redirect_to new_virus_path
    end
  end

  def update
    if @virus.update(virus_params)
      render 'index'
    else
      render 'edit'
    end
  end

  def destroy
    @virus.destroy
    redirect_to root_path
  end

  private

  def virus_params
    params.require(:virus).permit(:team_id, :post_id)
  end

  def find_virus
    @virus = Virus.find(params[:id])
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
      if current_user.teamowner
        if current_user.teamowner == @virus.teamowner

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
