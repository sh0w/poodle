class TakesCourse < ActiveRecord::Base
  attr_accessible :course_id, :lesson_progress, :user_id

  belongs_to :user
  belongs_to :course
end
