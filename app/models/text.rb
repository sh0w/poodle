class Text < ActiveRecord::Base
  attr_accessible :resource_id, :text
  
  #belongs_to :resource, :dependent => :destroy
  has_one :resource, :as => :attachment
end
