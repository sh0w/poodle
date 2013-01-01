class Lesson < ActiveRecord::Base
  attr_accessible :course_id, :description, :title, :position, :image

  belongs_to :course
  has_many :pages, :dependent => :destroy

  validates_presence_of :course_id, :title
  validates_length_of :title, :minimum => 3
  
  has_attached_file :image, :styles => { :thumb => "100x100>", :medium => "240x240" }
  
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']

end
