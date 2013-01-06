class Course < ActiveRecord::Base
  attr_accessible :description, :title, :image, :category_ids

  has_many :lessons, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :activities, :dependent => :destroy

  has_and_belongs_to_many :categories

  has_one :creates_course
  has_one :user, :through => :creates_course, :dependent => :destroy

  has_many :takes_course, :dependent => :destroy
  has_many :users, :through => :takes_course

  validates_presence_of :title, :description
  validates_uniqueness_of :title
  validates_uniqueness_of :slug

  def taken_by_user(user_id)
   TakesCourse.where(:user_id => user_id, :course_id => id)
  end
  
  has_attached_file :image, :styles => { :thumb => "100x100>", :medium => "240>x240" }
  
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']

  before_create :create_slug

  def to_param
    slug
  end

  def create_slug
    self.slug = self.title.parameterize
  end

end
