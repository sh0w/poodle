class CreatePagecomments < ActiveRecord::Migration
  def change
    create_table :pagecomments do |t|
      t.integer :rating
      t.text :content
      t.integer :user_id
      t.integer :page_id

      t.timestamps
    end
  end
end
