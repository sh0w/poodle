class TextsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_text, :only => [:show, :update, :destroy, :edit]
  before_filter :find_course
  before_filter :course_public!
  before_filter :find_lesson, :except => [:destroy]
  before_filter :find_page,   :except => [:destroy]
  before_filter :create_resource, :only => :create

  def find_text
    @text = Text.find(params[:id])
    @resource = Resource.find(@text.resource_id)
  end

  # GET /texts/new
  # GET /texts/new.json
  def new
    @resource = Resource.new    
    @text = Text.new
  end

  # GET /texts/1/edit
  def edit
  end

  # POST /texts
  # POST /texts.json
  def create


    @text = Text.new(params[:text])
    @text.resource_id = @resource.id
    @text.save

    @resource.attachment = @text
    @resource.save
    
    respond_to do |format|
      if @text.update_attributes(params[:text]) && @resource.update_attributes(params[:resource])
        format.html { redirect_to edit_course_path(@course), notice: 'Text was successfully updated.' }
        format.js
      end
    end    
  end

  # PUT /texts/1
  # PUT /texts/1.json
  def update

    respond_to do |format|
      if @text.update_attributes(params[:text]) && @resource.update_attributes(params[:resource])
        format.js
      end
    end
  end

end
