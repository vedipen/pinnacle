class AddUsertypeToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :usertype, :string
  end
end
