class CoursesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_course, :only => [:show, :update, :destroy, :edit, :editTitle, :editDescription, :editImage, :take_course]
  before_filter :get_lessons, :only => [:show, :edit]
  before_filter :takes_course?, :only => [:show, :take_course]


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
    @creator = User.find(@course.creates_course.user_id)
    @takes_course = @course.takes_course.find_by_user_id(current_user.id) if user_signed_in?

    if(! @takes_course.blank?)

      if @lesson_progress = @course.lessons.find_by_id(@takes_course.lesson_progress)
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
        Activity.create(:creator_id => current_user.id, :course_id => @course.id, :text =>"create_course")

        CreatesCourse.create(:user_id => current_user.id, :course_id => @course.id )

        @lesson = Lesson.create(:position => 1, :course_id => @course.id, :title => "Lesson 1")

        Page.create(:position => 1, :lesson_id => @lesson.id)

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
          Activity.create(:creator_id => current_user.id, :course_id => @course.id, :text =>"start_course")

          format.html { redirect_to "/courses/#{@course.slug}/lessons/#{@first_lesson.id}/pages/#{@first_page.id}", notice: "Welcome to #{@course.title}" }
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
