class Comment < ActiveRecord::Base
  attr_accessible :content, :course_id, :page_id, :rating, :user_id

  belongs_to :course
  has_many :activities
end
