class GoalsController < ApplicationController
  before_action :set_goal, :set_habit, only: [:show, :update_milestones, :update, :edit, :destroy]


  def index
    @goals = @habit.goals
  end

  # def new
  # end
  #
  # def create
  # end
  #
  # def edit
  # end
  #
  def update
    if @goal.update(goal_params)
      binding.pry
      redirect_to habit_goal_path(@habit.id, @goal.id), notice: 'Goal was successfully updated.'
    else
      render :show
    end
  end

  def show
  end

  def destroy
    @goal.destroy
    redirect_to @habit, :notice => "Goal Deleted"
  end

  def update_milestones
    # binding.pry
    if params[:goal][:milestone_ids].present?
      milestone_id = params[:goal][:milestone_ids].to_i
      milestone = Milestone.find_by(id: milestone_id)
      if @goal.milestones.include?(milestone)
        "#{milestone.description} is already a milestone for the @#{@goal.name}"
      else
        @goal.milestones << milestone
        @goal.save
      end
    end

    params[:goal][:milestones_attributes].each do |key, value|
      value.each do |k, v|
        if v.present?
          Milestone.find_or_create_by(description: v) do |milestone|
            milestone.description = v
            @goal.milestones << milestone
          end
        end
      end
      @goal.save
    end

    redirect_to habit_goal_path(@habit.id, @goal.id)
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

    def goal_params
      params.required(:goal).permit(:description, :habit_id, :milestone_ids => [], :milestones_attributes => [:description])
    end
end
