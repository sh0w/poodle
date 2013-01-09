class DropPagecomments < ActiveRecord::Migration
  def change
    drop_table :pagecomments
  end
end
