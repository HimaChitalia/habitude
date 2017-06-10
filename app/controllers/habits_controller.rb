class HabitsController < ApplicationController
  before_action :set_habit, only: [:show, :edit, :update, :destroy]

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

# <ActionController::Parameters {"utf8"=>"✓", "_method"=>"patch", "authenticity_token"=>"iCctuQ4TMeHw/fJWoXhslyAKaEtUJyghuuF357E5uGGc6PoOk6UTJoX4jS4JPAaLUhoH/eVCxnt5c8opVhD0gg==",
#   "habit"=>{"goals_attributes"=>{"0"=>{"name"=>""}}, "goal_ids"=>"6"}, "commit"=>"Update Habit", "controller"=>"habits", "action"=>"update", "id"=>"7"} permitted: false>

  def destroy
    @habit.destroy
    redirect_to habits_url, notice: 'Habit was successfully destroyed.'
  end

  private
    def set_habit
      @habit = Habit.find(params[:id])
    end

    def habit_params
      params.required(:habit).permit(:name, :description, :category_id, :goal_ids, :goals_attributes => [:name])
    end
end
