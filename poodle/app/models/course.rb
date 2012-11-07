class Course < ActiveRecord::Base
  attr_accessible :description, :title

  has_many :lessons, :dependent => :destroy


end
