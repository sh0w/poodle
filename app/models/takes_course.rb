class TakesCourse < ActiveRecord::Base
  attr_accessible :course_id, :lesson_progress, :user_id
end
