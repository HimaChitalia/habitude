class GoalsController < ApplicationController
  before_action :set_goal, :set_habit,  only: [:show, :update_statuses, :update, :edit, :destroy]

  def index
    @goals = @habit.goals
  end

  def edit
    authorize_user(@habit)
  end

  def update
    authorize_user(@habit)
    if @goal.update(goal_params)
      redirect_to habit_goal_path(@habit.id, @goal.id), notice: 'Goal was successfully updated.'
    else
      render :show
    end
  end

  def show
  end

  def destroy
    authorize_user(@habit)
    @goal.destroy
    redirect_to @habit, :notice => "Goal Deleted"
  end

  def update_statuses
    params[:goal][:statuses_attributes].each do |key, value|
      value.each do |k, v|
        status = Status.new
        status.description = v
        @goal.statuses << status
        @goal.save
        # else
        # , notice: "An error occured. Please try again."
        redirect_to habit_goal_path(@habit, @goal)
      end
    end
  end

  private

    def set_goal
      @goal = Goal.find(params[:id])
    end

    def set_habit
      @habit = Habit.find(params[:habit_id])
    end

    def goal_params
      params.required(:goal).permit(:description, :habit_id, :statuses_attributes => [:description])
    end
end
