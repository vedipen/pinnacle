class AddAttachmentImageToPmcmembers < ActiveRecord::Migration[5.0]
  def self.up
    change_table :pmcmembers do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :pmcmembers, :image
  end
end
