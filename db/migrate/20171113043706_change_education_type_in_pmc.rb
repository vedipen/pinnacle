class ChangeEducationTypeInPmc < ActiveRecord::Migration[5.1]
  def change
    change_column :pmcmembers, :education, :string
  end
end
