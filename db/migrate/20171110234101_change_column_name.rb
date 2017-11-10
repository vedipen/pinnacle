class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :user_od, :user_id
  end
end
