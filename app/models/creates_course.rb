class CreatesCourse < ActiveRecord::Base
  attr_accessible :course_id, :user_id

  belongs_to :course, :dependent => :destroy
  belongs_to :user
end
