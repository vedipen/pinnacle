class BetsController < ApplicationController
  before_action :find_bet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :same_user_or_admin_can_edit, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user_spectator

  def index
    @bets = Bet.joins(:user).order("user_id ASC")
    @sum1=0
    if @bets!=nil
      @bets.each do |profile|
        if profile.user == current_user
          @sum1+=10
        end
      end
    end

  end

  def show
  end

  def new
    if current_user.usertype=="Spectator"
      @bets = Bet.joins(:user).order("user_id ASC")
      @bet =  current_user.bets.build
      @tempp = Post.where(events: true, hidden_transactions: true)
      @tempt = Team.all
      if @tempp.size==0 || @tempt.size==0 || current_user.bets.size==10
        flash[:alert] = "No balance or event available for transaction."
        redirect_to bets_path
      end
    end
  end

  def create
    if current_user.usertype=="Spectator"
      @bet = current_user.bets.build(bet_params)
      if @bet
        @sum=0
        for i in @bet.user.bets
          if i.post==@bet.post && i.team==@bet.team
            @sum=1
          end
        end
        if @sum>=1
          flash[:alert] = "Event " + @bet.post.title + " and team "+ @bet.team.name + " already has your bet."
          redirect_to new_bet_path
        else
          @bet.save
          flash[:notice] = "Transaction Successful. PMC is not responsible for any leaks. A transaction can't be deleted or edited once it is done. Contact PMC if any doubts."
          redirect_to bets_path
        end
      else
        redirect_to new_bet_path
      end
    end
  end

  def update
    if @bet.update(bet_params)
      render 'index'
    else
      render 'edit'
    end
  end

  def destroy
    @bet.destroy
    redirect_to root_path
  end

  private

  def bet_params
    params.require(:bet).permit(:user_id, :team_id, :post_id)
  end

  def find_bet
    @bet = Bet.find(params[:id])
  end

  def authenticate_user_spectator
    if current_user.usertype == "Spectator"

    else
      redirect_to root_path
    end
  end

  def same_user_or_admin_can_edit
    if current_user.usertype == "Admin" || current_user.usertype == "Spectator"

    else
      redirect_to root_path
    end
  end

end
