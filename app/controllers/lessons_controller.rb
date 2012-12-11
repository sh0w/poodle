class LessonsController < ApplicationController
  # GET /lessons
  # GET /lessons.json
  before_filter :find_lesson, :only => [:show, :update, :destroy, :edit, :updatePosition]
  before_filter :find_course, :except => [:delete]

  def find_course
    @course = Course.find(params[:course_id])
  end

  def find_lesson
    @lesson = Lesson.find(params[:id])
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lesson }
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

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = Lesson.new(params[:lesson])
    @lesson.course_id = @course.id
    @lesson.position = @course.lessons.count+1

    respond_to do |format|
      if @lesson.save
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
      else
        format.html { render action: "edit" }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  def updatePosition
   
  #  lesson = Lessons.find(params[:lesson_id]);    # lesson erhalten wir durch die URL - sh beforefilter find_lesson
  #  course = params[:course_id];                 # selbes mit course

    position = params[:position]

    # hier passiert das was wir wollen:
    # @lesson ist die Lesson die wir bearbeiten wollen
    # update_attributes(params[:lesson]) brauchen wir hier nicht, wir wollen ja nur ein attribut ändern (position):
    @lesson.position = position

    respond_to do |format|
      if @lesson.save          # anstatt update_attributes(params[:lesson]) muessen wir die änderungen nur noch speichern mit save
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
