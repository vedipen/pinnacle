class AddTeamToTeamowners < ActiveRecord::Migration[5.1]
  def change
    add_column :teamowners, :team_name, :string, default: "My Team Name"
  end
end
