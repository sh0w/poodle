class Resource < ActiveRecord::Base
  attr_accessible :headline, :page_id, :position
  
  belongs_to :page
  has_one :text, :dependent => :destroy
  has_one :link, :dependent => :destroy
  has_one :image, :dependent => :destroy
  has_one :upload, :dependent => :destroy
  has_one :video, :dependent => :destroy
  
  default_scope :order => 'position'
end
