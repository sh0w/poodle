class LinksController < ApplicationController
  
  before_filter :find_link, :only => [:show, :update, :destroy, :edit]
  before_filter :find, :except => [:destroy]
  before_filter :authenticate_user!

  def find
    @course = Course.find_by_slug(params[:course_id])
    @lesson = Lesson.find(params[:lesson_id])
    @page = Page.find(params[:page_id])
  end

  def find_link
    @link = Link.find(params[:id])
    @resource = Resource.find(@link.resource_id)
  end
  
  # GET /links
  # GET /links.json
  def index
    @links = Link.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @links }
    end
  end

  # GET /links/1
  # GET /links/1.json
  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @link }
    end
  end

  # GET /links/new
  # GET /links/new.json
  def new
    @resource = Resource.new 
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @resource = Resource.new(params[:resource])
    @resource.page_id = @page.id
    @resource.position = @page.resources.count+1    
    @resource.save
    
    @link = Link.new(params[:link])
    @link.resource_id = @resource.id
    @link.save
    
    respond_to do |format|
      if @link.update_attributes(params[:text]) && @resource.update_attributes(params[:resource])
        format.html { redirect_to edit_course_path(@course), notice: 'Text was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
        format.js
      end
    end  
  end

  # PUT /links/1
  # PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update_attributes(params[:text]) && @resource.update_attributes(params[:resource])
        format.html { redirect_to edit_course_path(@course), notice: 'Text was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy

    respond_to do |format|
      format.html { redirect_to edit_course_path(@course) }
      format.json { head :no_content }
    end
  end
end
