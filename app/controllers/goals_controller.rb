class GoalsController < ApplicationController
  before_action :set_goal, :set_habit, only: [:show, :edit, :update, :destroy]

  # def index
  #   @goals = @habit.goals
  # end

  def new
  end

  def create
  end

  def edit
  end

  def update
    if @goal.update(goal_params)
      redirect_to habit_goal_path(@habit.id, @goal.id), notice: 'Goal was successfully updated.'
    else
      render :show
    end
  end

  # <ActionController::Parameters {"utf8"=>"✓", "_method"=>"put",
  #   "authenticity_token"=>"jiTAuK8jGfEr2K+zz7lskLweDXg76bGoBGdtqYb+g4EzABQYKop5+eqTpxRfwiY/iTwbGJnW5vRPqCeXnewB7w==",
  #   "/habits/1/goals/1/milestones/1"=>{"milestones"=>{"description"=>""}, "milestone_ids"=>"45"}, "commit"=>"Update Goal",
  #   "controller"=>"goals", "action"=>"update", "habit_id"=>"1", "id"=>"1"} permitted: false>



  def show
  end

  def destroy
  end

  private

    def set_goal
      @goal = Goal.find(params[:id])
    end

    def set_habit
      @habit = Habit.find(params[:habit_id])
    end

    def set_user
      @user = @habit.user
    end

    # def set_user
    #   @user = @habit.user
    # end

    def goal_params
      params.required(:goal).permit(:description, :habit_id, :milestone_ids, :milestones_attributes => [:description])
    end
end
