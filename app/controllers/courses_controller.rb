class CoursesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_course, :only => [:show, :update, :destroy, :edit, :editTitle, :editDescription, :editImage, :take_course]
  before_filter :get_lessons, :only => [:show, :edit]
  before_filter :get_comments, :only => [:show]
  before_filter :takes_course?, :only => [:show, :take_course]
  before_filter :only_creator, :only => :destroy


  def find_course
    @course = Course.find_by_slug(params[:id])
  end

  def only_creator
    if @course.creates_course.user_id != current_user.id
      respond_to do |format|
          format.html { redirect_to course_path(@course), error: 'Sorry, only course managers can delete courses.' }
          format.json { head :no_content }
      end
    end

  end

  def get_lessons
    @lessons = @course.lessons.sort{|a,b|( a.position and b.position ) ? a.position <=> b.position : ( a.position ? -1 : 1 ) }
  end

  def get_comments
    @comments = @course.comments
  end

  def takes_course?
    @takes_course = TakesCourse.where("user_id = ? AND course_id = ?",current_user.id, @course.id).size
    @takes_course
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
    @takes_course = @course.takes_courses.find_by_user_id(current_user.id)
    @creator = User.find(@course.creates_course.user_id)

    if(! @takes_course.blank?)

      if @course.lessons.find_by_id(@takes_course.lesson_progress)
        @lesson_progress = @course.lessons.find_by_id(@takes_course.lesson_progress)
        if @lesson_progress.pages.find_by_id(@takes_course.page_progress)
          @page_progress = @lesson_progress.pages.find_by_id(@takes_course.page_progress)
        else
          @page_progress = @lesson_progress.pages.find_by_position(1)
        end

      else
        @lesson_progress = @course.lessons.find_by_position(1)
        @page_progress = @lesson_progress.pages.find_by_position(1)
      end

    end

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

  # GET /courses/1/edit
  def edit
  end
  
  def editDescription
  end
  
  def editTitle
  end
  
  def editImage
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])
    #@course.category_ids

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
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end


  def take_course

    if @course.taken_by_user(current_user.id).blank?
      @tc = TakesCourse.new
      @tc.user_id = current_user.id
      @tc.course_id = @course.id

      @first_lesson = @course.lessons.first
      @first_page = @first_lesson.pages.first

      @tc.lesson_progress = @first_lesson.id
      @tc.page_progress = @first_page.id

      respond_to do |format|
        if @tc.save
          @activity = Activity.new
          @activity.creator_id = current_user.id
          @activity.course_id = @course.id
          @activity.text = "start_course"
          @activity.save

          format.html { redirect_to "/courses/#{@course.slug}/lessons/#{@first_lesson.id}/pages/#{@first_page.id}", notice: 'Start this course now.' }
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

end
