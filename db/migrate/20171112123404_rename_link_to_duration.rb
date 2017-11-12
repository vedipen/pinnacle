class RenameLinkToDuration < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :link, :duration
  end
end
