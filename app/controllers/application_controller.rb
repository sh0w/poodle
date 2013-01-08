class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_found
    raise ActionController::RoutingError.new('Not Found')
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

  def find_course_lesson_page
    @course = Course.find_by_slug(params[:course_id])
    @lesson = Lesson.find(params[:lesson_id])
    @page = Page.find(params[:page_id])
  end

  def find_course
    @course = Course.find_by_slug(params[:id])
  end

  def get_lessons
    @lessons = @course.lessons.sort{|a,b|( a.position and b.position ) ? a.position <=> b.position : ( a.position ? -1 : 1 ) }
  end

end
