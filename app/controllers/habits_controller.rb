class HabitsController < ApplicationController
  before_action :set_habit, :habit_owner, only: [:show, :edit, :update, :destroy, :update_goals]
  before_action :set_category, only: [:index]

  def index
    if params[:category_id]
       @habits = Habit.search(params[:category_id]).recent
    else
       @habits = Habit.all.recent
    end
  end

  def show
  end

  def new
    if logged_in?
      @habit = Habit.new
    else
      redirect_to '/login', notice: 'You must login to create a habit!'
    end
  end

  def edit
    authorize_user(@habit)
  end

  def create
    @habit = Habit.new(habit_params)
    @habit.user_id = current_user.id if current_user
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

  def update_goals
    if params[:habit][:goal_ids].present?
      goal_id = params[:habit][:goal_ids].to_i
      goal = Goal.find_by(id: goal_id)
      if @habit.goals.include?(goal)
        "#{goal.name} is already a goal for the @#{@habit.name}"
      else
        @habit.goals << goal
        # binding.pry
        # @habit.goals.find(goal.id).milestones = []
        # binding.pry
        @habit.save
      end
    end

    params[:habit][:goals_attributes].each do |key, value|
      value.each do |k, v|
        if v.present?
          Goal.find_or_create_by(name: v) do |goal|
            goal.name = v
            @habit.goals << goal
            # @user.goals.find_by(goal.id).milestones = []
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

    def habit_owner
      @user = @habit.user
    end

    def set_category
      @category = Category.find(params[:category_id]) if params[:category_id]
    end

    def habit_params
      params.required(:habit).permit(:name, :description, :category_id, :goal_ids, :goals_attributes => [:name])
    end
end
