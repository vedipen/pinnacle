class OstocksController < ApplicationController
  before_action :find_ostock, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authenticate_user_admin, only: [:update, :edit]

  def index
    @ostocks = Ostock.joins(:user).order("created_at DESC")
  end

  def show
  end

  def new
    @ostock = current_user.ostocks.build
  end

  def create
    @ostock = current_user.ostocks.build(ostock_params)
    @ostock.currentsprice = @ostock.company.cstocks.last.price
    if @ostock.price == nil || @ostock.price < 0 || @ostock.user.wallstreetbal < @ostock.price
      flash[:alert]="Enter Price :/"
      render 'new'
    else
      if @ostock.save
        flash[:notice]="Successfully Bought!"
        @ostock.user.wallstreetbal -= @ostock.price
        @ostock.user.save
        redirect_to ostocks_path
      else
        flash[:alert]="Enter Price :/"
        render 'new'
      end
    end
  end

  def edit
  end

  def update
    if @ostock.update(ostock_params)
      redirect_to @ostock
    else
      render 'edit'
    end
  end

  def destroy
    if @ostock.currentsprice != nil
      flash[:notice]="Sold!"
      @ostock.user.wallstreetbal += ((@ostock.price.to_f/@ostock.currentsprice.to_f)*@ostock.company.cstocks.last.price).to_i
      @ostock.user.save
      @ostock.destroy
      redirect_to ostocks_path
    else
      flash[:alert]="Oops!"
      redirect_to ostocks_path
    end
  end

  private

  def find_ostock
    @ostock = Ostock.find(params[:id])
  end

  def authenticate_user_admin
    if current_user.usertype == "PMC" || current_user.usertype == "Admin"

    else
      redirect_to root_path
    end
  end

  def ostock_params
    params.require(:ostock).permit(:price, :company_id)
  end

end
