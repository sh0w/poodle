class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.string :headline
      t.string :text
      t.integer :position

      t.timestamps
    end
  end
end
