class Category < ActiveRecord::Base
  attr_accessible :name, :slug

  before_save :create_slug

  def to_param
    slug
  end

  def create_slug
    self.slug = self.name.parameterize
  end
end
