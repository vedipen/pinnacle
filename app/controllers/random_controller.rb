class RandomController < ApplicationController
  def index
    @count = Profile.where(team_id: nil).count
  end

  def select
    if Profile.where(team_id: nil).count > 0
      @random_profile = Profile.where(team_id: nil).order("RANDOM()").first
    else
      redirect_to root_path
    end
  end

end
