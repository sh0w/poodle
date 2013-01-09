class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:current]

  def show
    @user = User.find_by_username(params[:username]) || not_found
    #@created_courses

    @tc = TakesCourse.find_all_by_user_id(@user.id)

    @recent_activity = Activity.find_all_by_user_id(@user.id).reverse
  end

  def current
    respond_to do |format|
      format.html { redirect_to proc { user_url(current_user.username) } }
    end
  end

end