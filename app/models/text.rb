class Text < ActiveRecord::Base
  attr_accessible :resource_id, :text
  
  belongs_to :resource
end
