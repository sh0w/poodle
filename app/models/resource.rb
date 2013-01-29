class Resource < ActiveRecord::Base
  attr_accessible :headline, :page_id, :position, :attachment_attributes
  # resource_id, resource_type

  belongs_to :attachment, :polymorphic => true
  accepts_nested_attributes_for :attachment
  
  belongs_to :page
  
  default_scope :order => 'position'
end
