class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :headline
      t.string :link
      t.integer :position

      t.timestamps
    end
  end
end
