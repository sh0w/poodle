class UploadsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_upload, :only => [:show, :update, :destroy, :edit]
  before_filter :find_course, :except => [:destroy]
  before_filter :find_lesson, :except => [:destroy]
  before_filter :find_page,   :except => [:destroy]

  def find_upload
    @upload = Upload.find(params[:id])
    @resource = Resource.find(@upload.resource_id)
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

    @resource = Resource.create(
        :page_id => @page.id,
        :position => @page.resources.count+1
    )

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

end
