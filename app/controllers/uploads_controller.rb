class UploadsController < ApplicationController
  
  before_filter :find_upload, :only => [:show, :update, :destroy, :edit]
  before_filter :find, :except => [:destroy]
  before_filter :authenticate_user!

  def find
    @course = Course.find_by_slug(params[:course_id])
    @lesson = Lesson.find(params[:lesson_id])
    @page = Page.find(params[:page_id])
  end

  def find_upload
    @upload = Upload.find(params[:id])
    @resource = Resource.find(@upload.resource_id)
  end
  
  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = upload.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @uploads }
    end
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @upload }
    end
  end

  # GET /uploads/new
  # GET /uploads/new.json
  def new
    @resource = Resource.new    
    @upload = Upload.new
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
  # POST /uploads.json
  def create
  
    @resource = Resource.new(params[:resource])
    @resource.page_id = @page.id
    @resource.position = @page.resources.count+1    
    @resource.save
    
    @upload = Upload.new(params[:upload])
    @upload.resource_id = @resource.id
    @upload.save
    
    respond_to do |format|
      if @upload.update_attributes(params[:upload]) && @resource.update_attributes(params[:resource])
        format.html { redirect_to edit_course_path(@course), notice: 'upload was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
        format.js
      end
    end    
  end

  # PUT /uploads/1
  # PUT /uploads/1.json
  def update

    respond_to do |format|
      if @upload.update_attributes(params[:upload]) && @resource.update_attributes(params[:resource])
        format.html { redirect_to edit_course_path(@course), notice: 'upload was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
        format.js        
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to edit_course_path(@course) }
      format.json { head :no_content }
    end
  end
end
