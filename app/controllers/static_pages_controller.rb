class StaticPagesController < ApplicationController

  def explore
    @popular_courses = Course.all
  end

  def about
  end
end
