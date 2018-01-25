class AddWallstreetBalanceToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :wallstreetbal, :integer, default: 5000000
  end
end
