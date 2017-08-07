class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_habit, :set_user, only: [:new, :create, :destroy]


  def index
    @comments = Comment.all
  end

  def show
    render json: @comment
  end

  def new
    @comment = Comment.new
  end

  def edit
    authorize @comment
  end

  def create
    @comment = Comment.new(comment_params)
    authorize @comment
    @comment.user = @user
    @comment.habit = @habit
    @comment.user_name = @user.name
    if @comment.save
      render json: @comment
    else
      redirect_to comments_path, notice: 'Something went wrong, please try again.'
    end
  end

  def update
    authorize @comment
    if @comment.update(comment_params)
      redirect_to @comment, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @comment
    @comment.destroy
    redirect_to @habit, notice: 'Comment was successfully destroyed.'
  end

  private

    def set_habit
      @habit = Habit.find(params[:habit_id])
    end

    def set_user
      @user = current_user
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.required(:comment).permit(:description, :user_id, :habit_id)
    end
end
