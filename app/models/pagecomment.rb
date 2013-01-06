class Pagecomment < ActiveRecord::Base
  attr_accessible :content, :page_id, :rating, :user_id

  belongs_to :page
  belongs_to :user, :dependent => :destroy
  has_many :activities
end