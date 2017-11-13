class ChangeEducationToString < ActiveRecord::Migration[5.1]
  def change
    change_column :teamowners, :education, :string
  end
end
