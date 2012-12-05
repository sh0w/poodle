class Course < ActiveRecord::Base
  attr_accessible :description, :title

  has_many :lessons, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :activities

  has_and_belongs_to_many :categories


end
