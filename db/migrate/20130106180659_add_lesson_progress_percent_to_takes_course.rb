class AddLessonProgressPercentToTakesCourse < ActiveRecord::Migration
  def change
    add_column :takes_courses, :lesson_progress_percent, :integer, :default => 0
  end
end
