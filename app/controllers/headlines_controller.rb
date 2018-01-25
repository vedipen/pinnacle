class HeadlinesController < ApplicationController
  before_action :find_headline, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_user_admin, only: [:new, :create, :update, :destroy, :edit]

  def index
    @headlines = Headline.all.order("created_at DESC")
  end

  def show
  end

  def new
    @headline = current_user.headlines.build
  end

  def create
    @headline = current_user.headlines.build(headline_params)
    if @headline.save
      flash[:notice]="Added"
      redirect_to new_headline_path
    else
      flash[:alert]="Not Added"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @headline.update(headline_params)
      redirect_to @headline
    else
      render 'edit'
    end
  end

  def destroy
    @headline.destroy
    redirect_to root_path
  end

  private

  def find_headline
    @headline = Headline.find(params[:id])
  end

  def authenticate_user_admin
    if current_user.usertype == "PMC" || current_user.usertype == "Admin"

    else
      redirect_to root_path
    end
  end

  def headline_params
    params.require(:headline).permit(:title, :description)
  end

end
