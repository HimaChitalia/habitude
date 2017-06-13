class MilestonesController < ApplicationController

  before_action :set_habit, :set_goal, :set_milestone, :set_status, only: [:show, :update_statuses, :update, :edit, :destroy]

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

  def destroy
    statuses_array = @milestone.statuses
    if statuses_array.size > 0
      if statuses_array.size == 1
        statuses_array.clear
        @milestone.save
      elsif
        statuses_array.each do |status|
          if status.id == @status.id
            statuses_array -= [status]
            @milestone.statuses = statuses_array
            @milestone.save
          end
        end
      end
      redirect_to habit_goal__milestone_path(@habit, @goal, @milestone), :notice => "Status Deleted"
    else
      "An error occured"
    end
  end


  private

    def set_habit
      @habit = Habit.find(params[:habit_id])
    end

    def set_goal
      @goal = Goal.find(params[:goal_id])
    end

    def set_milestone
      @milestone = Milestone.find(params[:milestone_id])
    end

    def set_status
      @status = Status.find(params[:id])
    end

    def set_user
      @user = @habit.user
    end

    def status_params
      params.required(:status).permit(:description, :milestone_id)
    end


end