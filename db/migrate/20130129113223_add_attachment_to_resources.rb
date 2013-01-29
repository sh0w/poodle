class AddAttachmentToResources < ActiveRecord::Migration
  def change
    add_column :resources, :attachment_id, :integer
    add_column :resources, :attachment_type, :string
  end
end
