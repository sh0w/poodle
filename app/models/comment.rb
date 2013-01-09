class Comment < ActiveRecord::Base
  attr_accessible :content, :course_id, :page_id, :rating, :user_id

  belongs_to :course
  belongs_to :user
  has_many :activities, :dependent => :destroy

  validates :rating, :inclusion => 0..5

end
