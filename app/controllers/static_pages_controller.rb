class StaticPagesController < ApplicationController
  before_filter :authenticate_user!, :only => :dashboard

  def explore
    @popular_courses = Course.all
  end

  def about
  end
end
