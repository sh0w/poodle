class UploadsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_upload, :only => [:show, :update, :destroy, :edit]
  before_filter :find_course
  before_filter :course_public!
  before_filter :find_lesson, :except => [:destroy]
  before_filter :find_page,   :except => [:destroy]
  before_filter :create_resource, :only => :create

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
    @upload = Upload.new(params[:upload])
    @upload.resource_id = @resource.id
    @upload.save

    @resource.attachment = @upload
    @resource.save
    
    respond_to do |format|
      if @upload.update_attributes(params[:upload]) && @resource.update_attributes(params[:resource])
        format.js
      end
    end    
  end

  # PUT /uploads/1
  # PUT /uploads/1.json
  def update
    respond_to do |format|
      if @upload.update_attributes(params[:upload]) && @resource.update_attributes(params[:resource])
        format.js        
      end
    end
  end

end
