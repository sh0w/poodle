class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.string :text
      t.integer :resource_id

      t.timestamps
    end
  end
end
