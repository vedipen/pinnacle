class AddReferencesOfCompanyToOstock < ActiveRecord::Migration[5.1]
  def change
    add_reference :ostocks, :company, foreign_key: true
  end
end
