class CreateTakesCourses < ActiveRecord::Migration
  def change
    create_table :takes_courses do |t|
      t.integer :user_id
      t.integer :course_id
      t.integer :lesson_progress

      t.timestamps
    end
  end
end
