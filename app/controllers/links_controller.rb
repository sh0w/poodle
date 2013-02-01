class LinksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_link, :only => [:show, :update, :destroy, :edit]
  before_filter :find_course
  before_filter :course_public!
  before_filter :find_lesson, :except => [:destroy]
  before_filter :find_page, :except => [:destroy]
  before_filter :create_resource, :only => :create

  def find_link
    @link = Link.find(params[:id])
    @resource = Resource.find(@link.resource_id)
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

    @link = Link.new(params[:link])
    @link.resource_id = @resource.id
    
    if !@link.link.include? "http://"
       @link.link = "http://" + @link.link
    end


    @resource.attachment = @link
    @resource.save

    @link.save



    respond_to do |format|
      if @link.update_attributes(params[:text]) && @resource.update_attributes(params[:resource])
        format.js
      end
    end  
  end

  # PUT /links/1
  # PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update_attributes(params[:text]) && @resource.update_attributes(params[:resource])
        format.js
      end
    end
  end

end
