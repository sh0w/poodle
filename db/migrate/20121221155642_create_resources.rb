class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.integer :page_id
      t.integer :position
      t.string :headline

      t.timestamps
    end
  end
end
