class Course < ActiveRecord::Base
  attr_accessible :description, :title, :image, :category_ids
  attr_reader :rating

  has_many :lessons, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :activities, :dependent => :destroy

  has_and_belongs_to_many :categories

  has_one :creates_course, :dependent => :destroy
  has_one :user, :through => :creates_course

  has_many :takes_course
  has_many :users, :through => :takes_course

  validates_presence_of :title, :description
  validates_uniqueness_of :title
  validates_uniqueness_of :slug

  has_attached_file :image, :styles => { :thumb => "100x100>", :medium => "240>x240" }
  
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']

  before_create :create_slug

  def create_slug
    self.slug = self.title.parameterize
  end

  after_create do
    @lesson = Lesson.create(:position => 1, :course_id => self.id, :title => "Lesson 1")
    Page.create(:position => 1, :lesson_id => @lesson.id)
  end

  def to_param
    slug
  end

  def taken_by_user(user_id)
    TakesCourse.where(:user_id => user_id, :course_id => self.id)
  end


  def rating
    r = self.comments.average("rating") || 0
    r = Integer(r*2+0.9999)*0.5
    r = String(r).delete( "." )
    r
  end

  before_destroy :delete_takescourse

  def delete_takescourse
    @tc = TakesCourse.find_all_by_course_id(self.id)
    @tc.each do |tc|
      TakesCourse.delete(tc.id)

    end
  end

end
