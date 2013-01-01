class AddAttachmentImageToCourses < ActiveRecord::Migration
  def self.up
    change_table :courses do |t|
      t.has_attached_file :image
    end
  end

  def self.down
    drop_attached_file :courses, :image
  end
end
