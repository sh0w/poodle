class CoursesController < ApplicationController
  before_filter :authenticate_user!,    :except =>   [:index, :show]

  before_filter :find_course,           :except =>  [:show, :edit, :destroy]
  before_filter :find_course_params_id, :only =>    [:show, :edit, :destroy]

  before_filter :get_lessons,           :only => [:show, :edit]
  before_filter :takes_course?,         :only => [:show, :take_course]

  before_filter :course_public!,        :except => [:new, :create]

  def find_course_params_id
    @course = Course.find_by_slug(params[:id]) || not_found("Course")
  end

  def takes_course?
    if user_signed_in?
      @takes_course = TakesCourse.where("user_id = ? AND course_id = ?",current_user.id, @course.id).size
    else
      @takes_course = false
    end
    @takes_course
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @comments = @course.comments
    @creator = User.find(@course.creates_course.user_id) if !@course.creates_course.nil?
    @takes_course = @course.takes_course.find_by_user_id(current_user.id) if user_signed_in?

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new
    @categories = Category.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save

        Activity.create(:user_id => current_user.id, :course_id => @course.id, :text =>"create_course")
        CreatesCourse.create(:user_id => current_user.id, :course_id => @course.id )

        format.html { redirect_to proc { edit_course_url(@course) }, notice: 'Course was successfully created.' }
        format.json { render json: proc { edit_course_url(@post) }, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to edit_course_path(@course), notice: 'Course was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to explore_url }
      format.json { head :no_content }
    end
  end


  def take_course

    if @course.taken_by_user(current_user.id).blank?
      @tc = TakesCourse.new
      @tc.user_id = current_user.id
      @tc.course_id = @course.id
      @tc.lesson_progress = @course.lessons.first.id
      @tc.page_progress = @course.lessons.first.pages.first.id

      respond_to do |format|
        if @tc.save
          Activity.create(:user_id => current_user.id, :course_id => @course.id, :text =>"start_course")

          format.html { redirect_to "/courses/#{@course.slug}/lessons/#{@tc.lesson_progress}/pages/#{@tc.page_progress}", notice: "Welcome to #{@course.title}" }
          format.json { render json: @course, status: :created, location: @course }
        else
          format.html { render action: "show" }
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to @course, notice: 'You are already taking this course.' }
        format.json { render json: @course, status: :created, location: @course }
      end
    end

  end

  def toggleVisibility
    @course.published = ! @course.published
    if @course.save
      respond_to do |format|
        format.html { redirect_to edit_course_path(@course), notice: "Course visibility successfully updated." }
      end
    end
  end

  def edit
  end

  def editDescription
  end

  def editTitle
  end

  def editImage
  end

end
