class RemoveColumnFromActivity < ActiveRecord::Migration
  def up
    remove_column :activities, :creator_id
  end

  def down
    add_column :activities, :creator_id, :string
  end
end
