class CompaniesController < ApplicationController
  before_action :find_company, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_user_admin, only: [:new, :create, :update, :destroy, :edit]

  def index
    @companies = Company.all.order("name ASC")
  end

  def show
    @random_company = Company.where.not(id: @company).order("RANDOM()").first
  end

  def new
    @company = current_user.companies.build
  end

  def create
    @company = current_user.companies.build(company_params)

    if @company.save
      redirect_to @company
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to @company
    else
      render 'edit'
    end
  end

  def destroy
    @company.destroy
    redirect_to root_path
  end

  private

  def find_company
    @company = Company.find(params[:id])
  end

  def authenticate_user_admin
    if current_user.usertype == "PMC" || current_user.usertype == "Admin"

    else
      redirect_to root_path
    end
  end

  def company_params
    params.require(:company).permit(:name, :description)
  end

end
