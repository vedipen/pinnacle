class CrypticsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user_owner
  before_action :answer_found

  def index
    @cryy = Cryptic.joins(:teamowner)
    redirect_to new_cryptic_path
  end

  def new
    @cryy = Cryptic.joins(:teamowner)
    @cry =  current_user.teamowner.build_cryptic
  end

  def create
    @cry = current_user.teamowner.build_cryptic(cryptics_params)
    if @cry.answer.strip.downcase == "jon snow"
      @cry.save
      redirect_to cryptic_pdf_path
    else
      flash[:alert] = "Oooooops. Try Again Mate :)"
      redirect_to cryptics_path
    end
  end

  def update
  end

  def destroy
  end

  private

    def cryptics_params
      params.require(:cryptic).permit(:answer)
    end

    def authenticate_user_owner
      if current_user.usertype == "Owner"

      else
        redirect_to root_path
      end
    end

    def answer_found
      if current_user.teamowner.cryptic
        if current_user.teamowner.cryptic.answer.strip.downcase == "jon snow"
          redirect_to cryptic_pdf_path
        else

        end
      else

      end
    end

end
