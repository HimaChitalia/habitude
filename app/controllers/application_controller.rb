class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit

  helper_method :logged_in?, :current_user, :authorize_user
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authorize_user(habit)
    unless habit.user == current_user
      redirect_to habit_path(habit.id), notice: "You are not authorized to perform this action!"
    end
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    flash[:warning] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_to(request.referrer || root_path)
  end
  
end
