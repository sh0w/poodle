class Activity < ActiveRecord::Base
  attr_accessible :comment_id, :course_id, :creator_id, :text, :user_id
end
