class AddReferenceOfTeamToPmcmembers < ActiveRecord::Migration[5.1]
  def change
    add_reference :pmcmembers, :team, foreign_key: true
  end
end
