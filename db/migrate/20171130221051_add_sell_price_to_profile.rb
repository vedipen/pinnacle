class AddSellPriceToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :sell_price, :integer, default: 0
  end
end
