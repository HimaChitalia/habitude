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

    respond_to do |format|
      if @habit.save
        format.html { redirect_to @habit, notice: 'Habit was successfully created.' }
        format.json { render :show, status: :created, location: @habit }
      else
        format.html { render :new }
        format.json { render json: @habit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @habit.update(habit_params)
        format.html { redirect_to @habit, notice: 'Habit was successfully updated.' }
        format.json { render :show, status: :ok, location: @habit }
      else
        format.html { render :edit }
        format.json { render json: @habit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @habit.destroy
    respond_to do |format|
      format.html { redirect_to habits_url, notice: 'Habit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_habit
      @habit = Habit.find(params[:id])
    end

    def habit_params
      params.fetch(:habit, {})
    end
end