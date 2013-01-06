class CategoriesCourses < ActiveRecord::Base
  attr_accessible :category_id, :course_id
  belongs_to :course
  belongs_to :category
end
