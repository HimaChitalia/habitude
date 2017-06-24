class StatusesController < ApplicationController

  before_action :set_habit, :set_goal,:set_status, only: [:show, :update_statuses, :update, :edit, :destroy]

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
    # statuses_array = @goal.statuses
    # if statuses_array.size > 0
    #   if statuses_array.size == 1
    #     statuses_array.clear
    #     @goal.save
    #   elsif
    #     statuses_array.each do |status|
    #       if status.id == @status.id
    #         statuses_array -= [status]
    #         @goal.statuses = statuses_array
    #         @goal.save
    #       end
    #     end
    #   end
    #   redirect_to habit_goal_path(@habit, @goal), :notice => "Status Deleted"
    # else
    #   "An error occured"
    # end
     @status.destroy
     redirect_to habit_goal_path(@habit, @goal), :notice => "Status Deleted"
  end


  private

    def set_habit
      @habit = Habit.find(params[:habit_id])
    end

    def set_goal
      @goal = Goal.find(params[:goal_id])
    end

    # def set_milestone
    #   @milestone = Milestone.find(params[:milestone_id])
    # end

    def set_status
      @status = Status.find(params[:id]) if params[:id]
    end

    def set_user
      @user = @habit.user
    end

    def status_params
      params.required(:status).permit(:description, :milestone_id)
    end

end
