class AddHiddenAntivirusToTeamowner < ActiveRecord::Migration[5.1]
  def change
    add_column :teamowners, :hidden_antivirus, :integer, default: 1
  end
end
