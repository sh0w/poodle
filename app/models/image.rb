class Image < ActiveRecord::Base
  attr_accessible :resource_id, :image
  
  belongs_to :page


  has_one :resource, :as => :attachment
  
  has_attached_file :image, :styles => { :thumb => "30x30>", :medium => "240x240" }
  
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']
 
end
