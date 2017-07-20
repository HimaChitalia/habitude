class HabitsController < ApplicationController
  before_action :set_habit, :habit_owner, only: [:show, :edit, :update, :destroy, :update_goals]
  before_action :set_category, only: [:index]

  def index
    if params[:category_id]
      if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "postgresql"
        habits_array = Habit.joins(:categories_habits).where("category_id::text LIKE ?", params[:category_id])
        @habits = habits_array.recent
      elsif ActiveRecord::Base.connection.instance_values["config"][:adapter] == "sqlite3"
        habits_array = Habit.joins(:categories_habits).where("category_id LIKE ?", params[:category_id])
        @habits = habits_array.recent
      end
    else
       @habits = Habit.all.recent
    end
    respond_to do |format|
     format.html { render :index }
     format.json { render json: @habits}
   end
  end

  def show
      respond_to do |format|
       format.html { render :show }
       format.json { render json: @habit}
     end
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
    params[:habit][:goals_attributes].each do |key, value|
      value.each do |k, v|
        if v.present?
          Goal.find_or_create_by(name: v) do |goal|
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

    def habit_owner
      @user = @habit.user
    end

    def set_category
      @category = Category.find(params[:category_id]) if params[:category_id]
    end

    def habit_params
      params.required(:habit).permit(:name, :description, :goal_ids, :goals_attributes => [:name], category_ids: [])
    end
end
