class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.integer :resource_id

      t.timestamps
    end
  end
end
