class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :text
      t.integer :creator_id
      t.integer :user_id
      t.integer :course_id
      t.integer :comment_id

      t.timestamps
    end
  end
end
