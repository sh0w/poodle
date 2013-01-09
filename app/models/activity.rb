class Activity < ActiveRecord::Base
  attr_accessible :comment_id, :pagecomment_id, :course_id, :creator_id, :text, :user_id

  belongs_to :user
  belongs_to :comment


end
