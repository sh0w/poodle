class Link < ActiveRecord::Base
  attr_accessible :link, :resource_id
  
  #belongs_to :resource, :dependent => :destroy
  has_one :resource, :as => :attachment



end
