class TextsController < ApplicationController
  
  before_filter :find_text, :only => [:show, :update, :destroy, :edit]
  before_filter :find_course_lesson_page, :except => [:destroy]
  before_filter :authenticate_user!


  def find_text
    @text = Text.find(params[:id])
    @resource = Resource.find(@text.resource_id)
  end


  # GET /texts/1
  # GET /texts/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @text }
    end
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
  
    @resource = Resource.new(params[:resource])
    @resource.page_id = @page.id
    @resource.position = @page.resources.count+1    
    @resource.save
    
    @text = Text.new(params[:text])
    @text.resource_id = @resource.id
    @text.save
    
    respond_to do |format|
      if @text.update_attributes(params[:text]) && @resource.update_attributes(params[:resource])
        format.html { redirect_to edit_course_path(@course), notice: 'Text was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @text.errors, status: :unprocessable_entity }
        format.js
      end
    end    
  end

  # PUT /texts/1
  # PUT /texts/1.json
  def update

    respond_to do |format|
      if @text.update_attributes(params[:text]) && @resource.update_attributes(params[:resource])
        format.html { redirect_to edit_course_path(@course), notice: 'Text was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @text.errors, status: :unprocessable_entity }
        format.js        
      end
    end
  end

  # DELETE /texts/1
  # DELETE /texts/1.json
  def destroy
    @text.destroy

    respond_to do |format|
      format.html { redirect_to texts_url }
      format.json { head :no_content }
    end
  end
end
