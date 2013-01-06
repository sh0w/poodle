class TakesCourse < ActiveRecord::Base
  attr_accessible :course_id, :lesson_progress, :page_progress, :user_id, :lesson_progress_percent

  belongs_to :user
  belongs_to :course

  before_save update_progress

  def update_progess
    self.lesson_progress_percent = 50
  end


end
