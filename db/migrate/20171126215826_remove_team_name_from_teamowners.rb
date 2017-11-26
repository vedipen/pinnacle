class RemoveTeamNameFromTeamowners < ActiveRecord::Migration[5.1]
  def change
    remove_column :teamowners, :team_name, :string
  end
end
