class AddPageProgressToTakesCourse < ActiveRecord::Migration
  def change
    add_column :takes_courses, :page_progress, :integer
  end
end
