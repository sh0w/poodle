class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :resource_id
      t.string :video
      
      t.timestamps
    end
  end
end
