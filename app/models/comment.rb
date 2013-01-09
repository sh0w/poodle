class Comment < ActiveRecord::Base
  attr_accessible :content, :course_id, :page_id, :rating, :user_id

  belongs_to :course
  belongs_to :page
  belongs_to :user
  has_many :activities, :dependent => :destroy

  validates_presence_of :content, :course_id, :user_id
  #validates_presence_of :page_id?, :unless => :rating?

  validates_numericality_of :rating, :only_integer => true, :allow_nil => true,
                            :greater_than_or_equal_to => 1,
                            :less_than_or_equal_to => 5,
                            :message => "can only be whole between 1 and 5"


  before_validation do
    self.rating = nil if self.rating==0
  end

end
