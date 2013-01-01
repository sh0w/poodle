class AddAttachmentUploadToUploads < ActiveRecord::Migration
  def self.up
    change_table :uploads do |t|
      t.has_attached_file :upload
    end
  end

  def self.down
    drop_attached_file :uploads, :upload
  end
end
