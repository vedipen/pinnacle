class AddRoomAndPhoneToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :room, :string
    add_column :profiles, :phone, :string
  end
end
