class AddPagecommentIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :pagecomment_id, :integer
  end
end
