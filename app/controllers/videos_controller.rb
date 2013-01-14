class VideosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_video, :only => [:show, :update, :destroy, :edit]
  before_filter :find_course
  before_filter :course_public!
  before_filter :find_lesson, :except => [:destroy]
  before_filter :find_page, :except => [:destroy]
  before_filter :create_resource, :only => :create

  def find_video
    @video = Video.find(params[:id])
    @resource = Resource.find(@video.resource_id)
  end

  # GET /videos/new
  # GET /videos/new.json
  def new
    @resource = Resource.new 
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create

    @video = Video.new(params[:video])
    @video.resource_id = @resource.id
    @video.save

    respond_to do |format|
      if @video.update_attributes(params[:text]) && @resource.update_attributes(params[:resource])
        format.js
      end
    end  
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update_attributes(params[:text]) && @resource.update_attributes(params[:resource])
        format.js
      end
    end
  end

end
