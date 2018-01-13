class AddHiddenPointsToTeamowners < ActiveRecord::Migration[5.1]
  def change
    add_column :teamowners, :hidden_points, :integer, default: 75 
  end
end
