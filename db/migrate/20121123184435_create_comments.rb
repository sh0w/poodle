class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :rating
      t.text :content
      t.integer :user_id
      t.integer :page_id
      t.integer :course_id

      t.timestamps
    end
  end
end
