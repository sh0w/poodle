class Activity < ActiveRecord::Base
  attr_accessible :comment_id, :course_id, :text, :user_id

  belongs_to :user
  belongs_to :comment
end
