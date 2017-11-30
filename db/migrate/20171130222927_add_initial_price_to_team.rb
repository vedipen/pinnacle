class AddInitialPriceToTeam < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :initial_price, :integer, default: 200
  end
end
