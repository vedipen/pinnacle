class AddEventToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :events, :boolean, default: true
  end
end
