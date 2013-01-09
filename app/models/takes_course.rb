class TakesCourse < ActiveRecord::Base
  attr_accessible :course_id, :lesson_progress, :page_progress, :user_id, :lesson_progress_percent

  belongs_to :user
  belongs_to :course

  before_save :update_progress

  def update_progress

    @course = Course.find(self.course_id)
    @actual_lesson = Lesson.find(self.lesson_progress)

    number_of_pages = 0
    @course.lessons.each do |lesson|
      number_of_pages += lesson.pages.count
    end

    actual_lesson_position = @actual_lesson.position

    number_of_absolved_pages = 0

    @course.lessons.each do |lesson|
      if lesson.position < actual_lesson_position
        number_of_absolved_pages += lesson.pages.count
      end

      if lesson.position == actual_lesson_position
        number_of_absolved_pages += Page.find(self.page_progress).position
      end
    end

    self.lesson_progress_percent = Float(number_of_absolved_pages) / Float(number_of_pages) * 100

    if self.lesson_progress_percent == 100
      Activity.create(:user_id => self.user_id, :course_id => self.course_id, :text => "finish_course")
    end
  end


end
