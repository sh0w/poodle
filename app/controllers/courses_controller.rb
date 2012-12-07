class CoursesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_course, :only => [:show, :update, :destroy, :edit]

  def find_course
    @course = Course.find(params[:id])
  end

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        @activity = Activity.new
        @activity.creator_id = current_user.id
        @activity.course_id = @course.id
        @activity.text = "create_course"
        @activity.save

        @creates_course = CreatesCourse.new
        @creates_course.user_id = current_user.id
        @creates_course.course_id = @course.id
        @creates_course.save

        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
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
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end


  def take_course
    @tc = TakesCourse.new
    @tc.user_id = current_user.id
    @tc.course_id = @course.id
    @tc.lesson_progress = 1

    respond_to do |format|
      if @tc.save
        @activity = Activity.new
        @activity.creator_id = current_user.id
        @activity.course_id = @course.id
        @activity.text = "start_course"
        @activity.save

        format.html { redirect_to @course, notice: 'Start this course now.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "show" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end
end
