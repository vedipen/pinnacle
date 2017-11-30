class AddAttachmentImageToTeams < ActiveRecord::Migration[5.1]
  def self.up
    change_table :teams do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :teams, :image
  end
end
