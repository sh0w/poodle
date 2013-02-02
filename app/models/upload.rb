class Upload < ActiveRecord::Base
  attr_accessible :resource_id, :upload
  
 # belongs_to :resource, :dependent => :destroy
  has_one :resource, :as => :attachment
  
  has_attached_file :upload
  
  validates_attachment_size :upload, :less_than => 50.megabytes
  validates_attachment_content_type :upload, :content_type => ['application/pdf', 'application/msword', 'text/plain'], :if => :upload_attached?

  def upload_attached?
    self.upload.file?
  end
end
