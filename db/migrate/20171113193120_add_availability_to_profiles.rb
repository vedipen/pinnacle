class AddAvailabilityToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :availability, :string
  end
end
