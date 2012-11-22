class LessonsController < ApplicationController
  # GET /lessons
  # GET /lessons.json
  before_filter :find_lesson, :only => [:show, :update, :destroy, :edit]
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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lesson }
    end
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = Lesson.new(params[:lesson])
    @lesson.course_id = @course.id

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to [@course, @lesson], notice: 'Lesson was successfully created.' }
        format.json { render json: [@course, @lesson], status: :created, location: @lesson }
      else
        format.html { render action: "new" }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lessons/1
  # PUT /lessons/1.json
  def update

    respond_to do |format|
      if @lesson.update_attributes(params[:lesson])
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to lessons_url }
      format.json { head :no_content }
    end
  end
end
