class PagecommentsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_page, :except => [:delete]

  def find_page
    @page = Page.find(params[:page_id])
  end

  # GET /pagecomments
  # GET /pagecomments.json
  def index
    @pagecomments = Pagecomment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: [@page, @pagecomments] }
    end
  end

  # GET /pagecomments/1
  # GET /pagecomments/1.json
  def show
    @pagecomment = Pagecomment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: [@page, @pagecomments] }
    end
  end

  # GET /pagecomments/new
  # GET /pagecomments/new.json
  def new
    @pagecomment = Pagecomment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: [@page, @pagecomments] }
      format.js
    end
  end

  # GET /pagecomments/1/edit
  def edit
    @pagecomment = Pagecomment.find(params[:id])
  end

  # POST /pagecomments
  # POST /pagecomments.json
  def create
    @pagecomment = Pagecomment.new(params[:pagecomment])
    @pagecomment.page_id = @page.id
    @pagecomment.user_id = current_user.id

    respond_to do |format|
      if @pagecomment.save
        @activity = Activity.new
        @activity.creator_id = current_user.id
        @activity.page_id = @page.id
        @activity.pagecomment_id = @pagecomment.id
        @activity.text = "pagecomment_page"
        @activity.save

        format.html { redirect_to [@page, @pagecomments], notice: 'pagecomment was successfully created.' }
        format.json { render json: [@page, @pagecomments], status: :created, location: @pagecomment }
      else
        format.html { render action: "new" }
        format.json { render json: @pagecomment.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  # PUT /pagecomments/1
  # PUT /pagecomments/1.json
  def update
    @pagecomment = Pagecomment.find(params[:id])

    respond_to do |format|
      if @pagecomment.update_attributes(params[:pagecomment])
        format.html { redirect_to [@page, @pagecomments], notice: 'pagecomment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pagecomment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pagecomments/1
  # DELETE /pagecomments/1.json
  def destroy
    @pagecomment = Pagecomment.find(params[:id])
    @pagecomment.destroy

    respond_to do |format|
      format.html { redirect_to page_pagecomments_url }
      format.json { head :no_content }
    end
  end
end
