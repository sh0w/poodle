class CreatesCourse < ActiveRecord::Base
  attr_accessible :course_id, :user_id

  has_one :course
  has_one :user
end
