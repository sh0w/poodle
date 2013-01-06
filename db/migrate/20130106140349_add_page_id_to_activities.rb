class AddPageIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :page_id, :integer
  end
end
