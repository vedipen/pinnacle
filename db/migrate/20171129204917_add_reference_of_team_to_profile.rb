class AddReferenceOfTeamToProfile < ActiveRecord::Migration[5.1]
  def change
    add_reference :profiles, :team, foreign_key: true
  end
end
