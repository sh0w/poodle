class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:current]
  def show
    @user = User.find_by_username(params[:username]) || not_found
    #@created_courses
    @cc = CreatesCourse.find_all_by_user_id(@user.id)

    @created_courses = []
    if !@cc.nil?
      @cc.each do |cc|
        @created_courses.push(Course.find(cc.course_id))
      end
    end

    @recent_activity = Activity.where("creator_id = ? OR user_id = ?", @user.id, @user.id)
  end

  def current
    respond_to do |format|
      format.html { redirect_to proc { user_url(current_user.username) } }
    end
  end

end