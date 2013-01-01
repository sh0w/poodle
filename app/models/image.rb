class Image < ActiveRecord::Base
  attr_accessible :resource_id, :image
  
  belongs_to :resource
  
  has_attached_file :image, :styles => { :thumb => "100x100>", :medium => "300x300" }
  
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
  
  def thumb
      image_tag @agent.image.url(:medium), :class => "resource_image_thumb"
  end
end
