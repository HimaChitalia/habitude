class SessionsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    if params[:email].present?
      user = User.find_by(email: params[:email])
      binding.pry
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "You have successfully logged in"
      else
       if user
          flash[:alert] = "Your password is not correct"
        else
          flash[:alert] = "The email is invalid"
       end
        render 'new'
      end
    end
  end

  def destroy
    session.clear
    redirect_to '/', notice: "You have successfully logged out"
  end
end
