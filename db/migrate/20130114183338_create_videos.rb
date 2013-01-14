class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :video
      t.integer :resourceId

      t.timestamps
    end
  end
end
