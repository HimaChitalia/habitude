class WelcomeController < ApplicationController

  def greetings
    @habit = Habit.new
  end

end
