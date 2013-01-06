class ResourcesController < ApplicationController
  
  before_filter :find_resource, :only => [:show, :update, :destroy, :edit, :updatePosition]
  before_filter :find, :except => [:destroy]

  def find
    @course = Course.find_by_slug(params[:course_id])
    @lesson = Lesson.find(params[:lesson_id])
    @page = Page.find(params[:page_id])
  end

  def find_resource
    @resource = Resource.find(params[:id])
  end
  
  # GET /resources
  # GET /resources.json
  def index
    @resources = Resource.all
  end

  # GET /resources/1
  # GET /resources/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resource }
    end
  end

  # GET /resources/new
  # GET /resources/new.json
  def new
    @resource = Resource.new
  end

  # GET /resources/1/edit
  def edit
  end

  # POST /resources
  # POST /resources.json
  def create
    @resource = Resource.new(params[:resource])
    @resource.page_id = @page.id
    @resource.position = @resource.lessons.count+1

    respond_to do |format|
      if @resource.save
        format.html { redirect_to edit_course_path(@course), notice: 'Resource was successfully created.' }
        format.json { render json: @resource, status: :created, location: @resource }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /resources/1
  # PUT /resources/1.json
  def update

    respond_to do |format|
      if @resource.update_attributes(params[:resource])
        format.html { redirect_to edit_course_path(@course), notice: 'Resource was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end
  
  def updatePosition
   
    position = params[:position]
    @resource.position = position

    respond_to do |format|
      if @resource.save    
        format.html { redirect_to edit_course_path(@course), notice: 'Lesson was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.json
  def destroy
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to edit_course_path(@course) }
      format.json { head :no_content }
      format.js
    end
  end
end
