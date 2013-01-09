class CommentsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_course, :except => [:delete]


  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: [@course, @comments] }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new
    @comment.page_id = params[:page_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: [@course, @comments] }
      format.js
    end
  end


  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    @comment.course_id = @course.id
    @comment.user_id = current_user.id
    @comment.rating = nil unless @comment.page_id.blank?

    respond_to do |format|
      if @comment.save
        @activity = Activity.create(
            :user_id => current_user.id,
            :course_id => @course.id,
            :comment_id => @comment.id,
            :text => "comment_course"
        )

        format.html { redirect_to [@course, @comments], notice: 'Comment was successfully created.' }
        format.json { render json: [@course, @comments], status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    if current_user == @comment.user
      @comment.destroy

      respond_to do |format|
        format.html { redirect_to course_url }
        format.json { head :no_content }
        format.js
      end
    end
  end
end
