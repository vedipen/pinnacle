class AddBettingScoreToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :bettingscore, :integer, default:0
  end
end
