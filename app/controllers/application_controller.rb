class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  require 'pry'

  helper_method :logged_in?, :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
end
