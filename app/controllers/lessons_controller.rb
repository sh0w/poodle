class LessonsController < ApplicationController
  # GET /lessons
  # GET /lessons.json
  before_filter :find_lesson, :except => [:new, :create]
  before_filter :find_course, :except => [:destroy]
  before_filter :get_pages, :only => [:edit, :show]

  before_filter :authenticate_user!

  def find_course
    @course = Course.find_by_slug(params[:course_id])
  end

  def find_lesson
    @lesson = Lesson.find(params[:id])
  end
  
  def get_pages
    @pages = @lesson.pages.sort{|a,b|( a.position and b.position ) ? a.position <=> b.position : ( a.position ? -1 : 1 ) }
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    if ! @course.taken_by_user(current_user.id)

      respond_to do |format|
        format.html { redirect_to start_path(@course), notice: 'weiterleitung' }
        format.json { render json: start_path(@course), status: :created, location: @course }
      end
    else

    @lesson.pages.first.id
    respond_to do |format|
      format.html { redirect_to "/courses/#{@course.slug}/lessons/#{@lesson.id}/pages/#{@lesson.pages.first.id}", notice: 'weiterleitung' }
      format.json { render json: "/courses/#{@course.slug}/lessons/#{@lesson.id}/pages/#{@lesson.pages.first.id}", status: :created, location: @course }
    end
    end

  end

  # GET /lessons/new
  # GET /lessons/new.json
  def new
    @lesson = Lesson.new    
  end

  # GET /lessons/1/edit
  def edit
  end
  
  def editDescription
  end
  
  def editTitle
  end
  
  def editImage
  end
  

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = Lesson.new(params[:lesson])
    @lesson.course_id = @course.id
    @lesson.position = @course.lessons.count+1


    respond_to do |format|
      if @lesson.save

        @page = Page.new
        @page.position = 1
        @page.lesson_id = @lesson.id
        @page.save

        format.html { redirect_to edit_course_path(@course), notice: 'Lesson was successfully created.' }
        format.json { render json: @course, status: :created, location: @lesson }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /lessons/1
  # PUT /lessons/1.json
  def update

    respond_to do |format|
      if @lesson.update_attributes(params[:lesson])
        format.html { redirect_to edit_course_path(@course), notice: 'Lesson was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @lesson.errors, status: :unprocessable_entity } 
        format.js
      end
    end
  end

  def updatePosition
   
    position = params[:position]
    @lesson.position = position

    respond_to do |format|
      if @lesson.save    
        format.html { redirect_to edit_course_path(@course), notice: 'Lesson was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: lesson.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to edit_course_path(@course) }
      format.json { head :no_content }
      format.js
    end
  end

end
