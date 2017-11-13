class AddAttachmentImageToTeamowners < ActiveRecord::Migration[5.0]
  def self.up
    change_table :teamowners do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :teamowners, :image
  end
end
