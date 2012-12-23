class Resource < ActiveRecord::Base
  attr_accessible :headline, :page_id, :position
  
  belongs_to :page
end
