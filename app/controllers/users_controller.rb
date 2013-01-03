class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:current]
  def show
    @user = User.find_by_username(params[:username]) || not_found

  end

  def current
    @user = current_user

    respond_to do |format|
      format.html { render action: "show" }
    end
  end
end