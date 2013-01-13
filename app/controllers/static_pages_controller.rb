class StaticPagesController < ApplicationController

  def explore
    @popular_courses = Course.where(:published => true)
  end

  def about
  end
end
