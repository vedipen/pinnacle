class AddHiddenVirusToTeamowner < ActiveRecord::Migration[5.1]
  def change
    add_column :teamowners, :hidden_virus, :integer, default: 2
  end
end
