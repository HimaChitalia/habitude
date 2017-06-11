class HabitsController < ApplicationController
  before_action :set_habit, only: [:show, :edit, :update, :destroy, :update_goals]

  def index
    @habits = Habit.all
  end

  def show
  end

  def new
    @habit = Habit.new
  end

  def edit
  end

  def create
    @habit = Habit.new(habit_params)
    if @habit.save
      redirect_to @habit, notice: 'Habit was successfully created.'
    else
      render :new
    end
  end

  def update
    if @habit.update(habit_params)
      redirect_to @habit, notice: 'Habit was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @habit.destroy
    redirect_to habits_url, notice: 'Habit was successfully destroyed.'
  end

  # milestone = goal
  # goal = habit

  def update_goals
    if params[:habit][:goal_ids].present?
      goal_id = params[:habit][:goal_ids].to_i
      goal = Goal.find_by(id: goal_id)
      if @habit.goals.include?(goal)
        "#{goal.name} is already a goal for the @#{@habit.name}"
      else
        @habit.goals << goal
        @habit.save
      end
    end

    params[:habit][:goals_attributes].each do |key, value|
      value.each do |k, v|
        if v.present?
          Milestone.find_or_create_by(description: v) do |goal|
            goal.name = v
            @habit.goals << goal
          end
        end
      end
      @habit.save
    end

    redirect_to habit_path(@habit.id)
  end


  private
    def set_habit
      @habit = Habit.find(params[:id])
    end

    def habit_params
      params.required(:habit).permit(:name, :description, :category_id, :goal_ids, :goals_attributes => [:name])
    end
end
