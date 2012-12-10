class Lesson < ActiveRecord::Base
  attr_accessible :course_id, :description, :title, :position

  belongs_to :course
  has_many :pages, :dependent => :destroy

  validates_presence_of :course_id, :title
  validates_length_of :title, :minimum => 3

end
