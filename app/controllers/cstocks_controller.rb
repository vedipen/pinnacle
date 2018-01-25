class CstocksController < ApplicationController
  before_action :find_cstock, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_user_admin, only: [:new, :create, :update, :destroy, :edit]

  def index
    @cstocks = Cstock.all.order("created_at DESC")
  end

  def show
  end

  def new
    @cstock = current_user.cstocks.build
  end

  def create
    @cstock = current_user.cstocks.build(cstock_params)
    if @cstock.price == nil || @cstock.price < 0  
      flash[:alert]="Add Price"
      render 'new'
    else
      if @cstock.save
        flash[:notice]="Added"
        redirect_to new_cstock_path
      else
        flash[:alert]="Not Added"
        render 'new'
      end
    end
  end

  def edit
  end

  def update
    if @cstock.update(cstock_params)
      redirect_to @cstock
    else
      render 'edit'
    end
  end

  def destroy
    @cstock.destroy
    redirect_to root_path
  end

  private

  def find_cstock
    @cstock = Cstock.find(params[:id])
  end

  def authenticate_user_admin
    if current_user.usertype == "PMC" || current_user.usertype == "Admin"

    else
      redirect_to root_path
    end
  end

  def cstock_params
    params.require(:cstock).permit(:price, :company_id)
  end

end
