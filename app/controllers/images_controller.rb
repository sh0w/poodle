class ImagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_image, :only => [:show, :update, :destroy, :edit]
  before_filter :find_course
  before_filter :course_public!
  before_filter :find_lesson, :except => [:destroy]
  before_filter :find_page, :except => [:destroy]
  before_filter :create_resource, :only => :create

  def find_image
    @image = Image.find(params[:id])
    @resource = Resource.find(@image.resource_id)
  end


  # GET /images/1
  # GET /images/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/new
  # GET /images/new.json
  def new
    @resource = Resource.new    
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(params[:image])
    @image.resource_id = @resource.id

    @resource.attachment = @image
    @resource.save
    @image.save
    
    respond_to do |format|
      if @image.update_attributes(params[:image]) && @resource.update_attributes(params[:resource])
        format.html { redirect_to edit_course_path(@course), notice: 'image was successfully updated.' }
       # format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
  #      format.json { render json: @image.errors, status: :unprocessable_entity }
        format.js
      end
    end    
  end

  # PUT /images/1
  # PUT /images/1.json
  def update

    respond_to do |format|
      if @image.update_attributes(params[:image]) && @resource.update_attributes(params[:resource])
        format.html { redirect_to edit_course_path(@course), notice: 'image was successfully updated.' }
     #   format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
     #   format.json { render json: @image.errors, status: :unprocessable_entity }
        format.js        
      end
    end
  end
end
