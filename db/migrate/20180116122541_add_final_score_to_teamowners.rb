class AddFinalScoreToTeamowners < ActiveRecord::Migration[5.1]
  def change
    add_column :teamowners, :finalscore, :integer, default: 0
  end
end
