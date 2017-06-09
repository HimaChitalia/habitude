class GoalsController < ApplicationController

  def new
  end

  def create
  end

  private

  def goal_params
    params.required(:goal).permit(:description)
  end
end
