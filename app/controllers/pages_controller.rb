class PagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_course
  before_filter :course_public!
  before_filter :find_lesson, :except => [:destroy]
  before_filter :find_lesson_params_id, :except => [:create, :new]
  before_filter :get_resources, :only => [:edit, :show]

  def find_lesson_params_id
    @page = Page.find(params[:id])
  end

  def get_resources
    @resources = @page.resources
  end
  

  # GET /pages/1
  # GET /pages/1.json
  def show
    @comments = @page.comments
    @tc = @course.takes_course.find_by_user_id(current_user.id)

    # wenn der user diesen kurs noch nicht belegt hat -> leite zu course-start (erste lesson, erste page) weiter!!!!
    if(@tc.nil?)
      respond_to do |format|
        format.html { redirect_to start_path(@course), notice: "Welcome to #{@course.title}" }
        format.json { render json: start_path(@course), status: :created, location: @course }
      end
      return
    end

    @actual_lesson = @course.lessons.find_by_id(@tc.lesson_progress) || @course.lessons.find_by_position(1)
    @actual_page = @lesson.pages.find_by_id(@tc.page_progress) || @lesson.pages.find_by_position(1)

    if @lesson.position >= @actual_lesson.position and @page.position >= @actual_page.position
      @tc.lesson_progress = @lesson.id
      @tc.page_progress = @page.id
      @tc.save
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new
    
    @page.lesson_id = @lesson.id
    @page.position = @lesson.pages.count+1

    respond_to do |format|
      if @page.save
        format.html { redirect_to edit_course_path(@course), notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # GET /pages/1/edit
  def edit
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy

    respond_to do |format|
      format.html { redirect_to edit_course_path(@course) }
      format.json { head :no_content }
      format.js
    end
  end

  def updatePosition
    @page.position = params[:position]
    @page.save
  end
end
