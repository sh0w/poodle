class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_found msg=""
    raise ActionController::RoutingError.new(msg.blank? ? 'Not Found': msg + " not found")
  end

  def to_slug
    #strip the string
    ret = self.strip

    #blow away apostrophes
    ret.gsub! /['`]/,""

    # @ --> at, and & --> and
    ret.gsub! /\s*@\s*/, " at "
    ret.gsub! /\s*&\s*/, " and "

    # german special characters äöüß
    #ret.gsub(/[äöü]/) do |match|
    #  case match
    #    when "ä" 'ae'
    #    when "ö" 'oe'
    #    when "ü" 'ue'
    #    when "ß" 'ss'
    #  end
    #end

    #replace all non alphanumeric, dashes or periods with underscore
    ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'

    #convert double dashes to single
    ret.gsub! /_+/,"-"

    #strip off leading/trailing underscore
    ret.gsub! /\A[_\.]+|[_\.]+\z/,""
    ret.gsub! /\A[-\.]+|[-\.]+\z/,""

    ret
  end

  def find_course
    @course = Course.find_by_slug(params[:course_id])
  end

  def find_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def find_page
    @page = Page.find(params[:page_id])
  end

  def find_resource
    @resource = Resource.find(params[:resource_id])
  end

  def get_lessons
    @lessons = @course.lessons.sort{|a,b|( a.position and b.position ) ? a.position <=> b.position : ( a.position ? -1 : 1 ) }
  end

  def create_resource
    @resource = Resource.create(
        :page_id => @page.id,
        :position => @page.resources.count+1
    )
  end

  def course_public!
    redirect_to "/explore", :notice => "Sorry, this course is not public." unless
        @course.published or (user_signed_in? and @course.creates_course.user_id == current_user.id)
  end

end
