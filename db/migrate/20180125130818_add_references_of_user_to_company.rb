class AddReferencesOfUserToCompany < ActiveRecord::Migration[5.1]
  def change
    add_reference :companies, :user, foreign_key: true
  end
end
