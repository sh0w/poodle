class CreatesCourse < ActiveRecord::Base
  attr_accessible :course_id, :user_id

  has_one :course, :dependent => :destroy
  has_one :user, :dependent => :destroy
end
