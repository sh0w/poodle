class Page < ActiveRecord::Base
  attr_accessible :lesson_id, :position

  belongs_to :lesson
  validates_presence_of :lesson_id
  
  has_many :resources, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  default_scope :order => 'position'
  
  def is_first_page
    if self.lesson.pages.find_by_position(self.position - 1)
      0
    else
      1
    end
  end
  
  def is_last_page
    if self.lesson.pages.find_by_position(self.position + 1)
      0
    else
      1
    end
  end
  
  def previous_lesson
    if self.lesson.course.lessons.find_by_position(self.lesson.position - 1)
      self.lesson.course.lessons.find_by_position(self.lesson.position - 1)
    else
      -1
    end
  end
  
  def next_lesson
    if self.lesson.course.lessons.find_by_position(self.lesson.position + 1)
      self.lesson.course.lessons.find_by_position(self.lesson.position + 1)
    else
      -1
    end
  end
  
  def previous_page
    if self.lesson.pages.find_by_position(self.position - 1)
      self.lesson.pages.find_by_position(self.position - 1)
    else
      unless self.previous_lesson == -1
        self.lesson.course.lessons.find_by_position(self.previous_lesson.position).pages.last
      else
        -1
      end
    end   
  end
  
  def next_page
    if self.lesson.pages.find_by_position(self.position + 1)
      self.lesson.pages.find_by_position(self.position + 1)
    else
      unless self.next_lesson == -1
        self.lesson.course.lessons.find_by_position(self.next_lesson.position).pages.first
      else
        -1
      end
    end   
  end

end
