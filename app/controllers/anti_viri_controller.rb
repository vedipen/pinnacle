class AntiViriController < ApplicationController
  before_action :find_anti_virus, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :same_user_or_admin_can_edit, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user_owner

  def index
    @anti_viri = AntiVirus.joins(:teamowner).order("post_id ASC")
  end

  def show
  end

  def new
    @anti_viri = AntiVirus.joins(:teamowner).order("post_id ASC")
    @anti_virus =  current_user.teamowner.anti_viri.build
    @tempp = Post.where(events: true, hidden_transactions: true)
    if @tempp.size==0 || current_user.teamowner.hidden_antivirus < 1
      flash[:alert] = "No event or AntiVirus available for transaction."
      redirect_to anti_viri_path
    end
  end

  def create
    @anti_virus = current_user.teamowner.anti_viri.build(anti_virus_params)
    if @anti_virus
      @sum=0
      @flag=false
      for i in @anti_virus.teamowner.anti_viri
        @sum+=1
        if i.post==@anti_virus.post
          @flag=true
        end
      end
      if @flag==true
        flash[:alert] = "Event " + @anti_virus.post.title + " already has your AntiVirus."
        redirect_to new_anti_virus_path
      else
        @sum+=1
        if @sum>1 || current_user.teamowner.hidden_antivirus<1
          flash[:alert] = "No AntiViruses left."
          redirect_to new_anti_virus_path
        else
          @anti_virus.save
          flash[:notice] = "AntiVirus successfully loaded. Please keep this confidential. PMC is not responsible for any leaks. A transaction can't be deleted or edited once it is done. Contact PMC if any doubts."
          current_user.teamowner.hidden_antivirus-=1
          current_user.teamowner.save
          redirect_to anti_viri_path
        end
      end
    else
      redirect_to new_anti_virus_path
    end
  end

  def update
    if @anti_virus.update(anti_virus_params)
      render 'index'
    else
      render 'edit'
    end
  end

  def destroy
    @anti_virus.destroy
    redirect_to root_path
  end

  private

  def anti_virus_params
    params.require(:anti_virus).permit(:post_id)
  end

  def find_anti_virus
    @anti_virus = AntiVirus.find(params[:id])
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
        if current_user.teamowner == @anti_virus.teamowner

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
