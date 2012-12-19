class PagesController < ApplicationController

  before_filter :find_page, :only => [:show, :update, :destroy, :edit, :updatePosition]
  before_filter :find_lesson, :except => [:destroy]
  before_filter :find_course, :except => [:destroy]

  def find_course
    @course = Course.find(params[:course_id])
  end

  def find_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def find_page
    @page = Page.find(params[:id])
  end
  
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show

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

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])
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
   
    position = params[:position]
    @page.position = position

    respond_to do |format|
      if @page.save          
        format.html { redirect_to edit_course_path(@course), notice: 'Lesson was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: lesson.errors, status: :unprocessable_entity }
      end
    end
  end
end
