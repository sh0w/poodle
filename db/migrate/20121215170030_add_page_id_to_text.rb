class AddPageIdToText < ActiveRecord::Migration
  def change
    add_column :texts, :page_id, :integer
  end
end
