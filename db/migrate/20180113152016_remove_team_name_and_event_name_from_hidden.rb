class RemoveTeamNameAndEventNameFromHidden < ActiveRecord::Migration[5.1]
  def change
    remove_column :hiddens, :team_name, :string
    remove_column :hiddens, :event_name, :string
  end
end
