class MilestonesController < ApplicationController

  before_action :set_goal, :set_habit, :set_milestone, only: [:show, :update_statuses, :update, :edit, :destroy]

  def new
  end

  def create
  end

  def edit
  end

  def show
  end

  def update
  end

  def update_statuses
    # binding.pry
    if params[:milestone][:status_ids].present?
      status_id = params[:milestone][:status_ids].to_i
      status = Status.find_by(id: status_id)
      if @milestone.statuses.include?(status)
        "#{status.description} is already a status for the #{@milestone.description}"
      else
        @milestone.statuses << status
        @milestone.save
      end
    end

    params[:milestone][:statuses_attributes].each do |key, value|
      value.each do |k, v|
        if v.present?
          Status.find_or_create_by(description: v) do |milestone|
            status.description = v
            @milestone.statuses << status
          end
        end
      end
      @milestone.save
    end

    redirect_to habit_goal_milestone_path(@habit.id, @goal.id, @milestone.id)
  end


  private

    def set_milestone
      @milestone = Milestone.find(params[:id])
    end

    def set_goal
      @goal = Goal.find(params[:goal_id])
    end

    def set_habit
      @habit = Habit.find(params[:habit_id])
    end

    def set_user
      @user = @habit.user
    end

    def milestone_params
      params.required(:milestone).permit(:description, :goal_id, :status_ids => [], :statuses_attributes => [:description])
    end


end
