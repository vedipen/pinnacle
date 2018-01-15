class HiddensController < ApplicationController
  before_action :find_hidden, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :same_user_or_admin_can_edit, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user_owner

  def index
    @hiddens = Hidden.joins(:teamowner).order("team_id ASC")
  end

  def show
  end

  def new
    @hiddens = Hidden.joins(:teamowner).order("team_id ASC")
    @hidden =  current_user.teamowner.hiddens.build
    @tempp = Post.where(events: true, hidden_transactions: true)
    if @tempp.size==0
      flash[:alert] = "No event available for transaction"
      redirect_to hiddens_path
    end
  end

  def create
    @hidden = current_user.teamowner.hiddens.build(hidden_params)
    if @hidden
      @sum=0
      for i in @hidden.teamowner.hiddens
        if i.post==@hidden.post
          @sum+=i.amount
        end
      end
      @sum+=@hidden.amount
      if @sum>15 || @hidden.amount > current_user.teamowner.hidden_points
        flash[:alert] = "Event " + @hidden.post.title + " can only have transactions of 15MB in total."
        redirect_to new_hidden_path
      else
        @hidden.save
        flash[:notice] = "Transaction Successful. Please keep this confidential. PMC is not responsible for any leaks. A transaction can't be deleted or edited once it is done. Contact PMC if any doubts."
        current_user.teamowner.hidden_points-=@hidden.amount
        current_user.teamowner.save
        redirect_to hiddens_path
      end
    else
      redirect_to new_hidden_path
    end
  end

  def update
    if @hidden.update(hidden_params)
      render 'index'
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
    params.require(:hidden).permit(:amount, :team_id, :post_id)
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
