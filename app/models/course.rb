class Course < ActiveRecord::Base
  attr_accessible :description, :title

  has_many :lessons, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :activities

  has_and_belongs_to_many :categories

  has_one :creates_course
  has_one :user, :through => :creates_course

  has_many :takes_courses
  has_many :users, :through => :takes_course

  def taken_by_user(user_id)
   TakesCourse.where(:user_id => user_id, :course_id => id)
  end

end
