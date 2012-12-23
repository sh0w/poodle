class Page < ActiveRecord::Base
  attr_accessible :lesson_id, :position

  belongs_to :lesson
  validates_presence_of :lesson_id
  
  has_many :resources
end
