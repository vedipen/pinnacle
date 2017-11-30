class AddBasePriceToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :base_price, :integer, default: 10
  end
end
