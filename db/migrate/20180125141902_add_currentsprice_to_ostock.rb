class AddCurrentspriceToOstock < ActiveRecord::Migration[5.1]
  def change
    add_column :ostocks, :currentsprice, :integer
  end
end
