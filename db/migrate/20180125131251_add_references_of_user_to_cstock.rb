class AddReferencesOfUserToCstock < ActiveRecord::Migration[5.1]
  def change
    add_reference :cstocks, :user, foreign_key: true
  end
end
