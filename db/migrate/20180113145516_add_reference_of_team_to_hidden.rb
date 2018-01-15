class AddReferenceOfTeamToHidden < ActiveRecord::Migration[5.1]
  def change
    add_reference :hiddens, :team, foreign_key: true
  end
end
