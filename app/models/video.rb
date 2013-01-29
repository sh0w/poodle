class Video < ActiveRecord::Base 
  attr_accessible :video, :resource_id
  
 # belongs_to :resource, :dependent => :destroy
  has_one :resource, :as => :attachment
end
