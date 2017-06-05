class SessionsController < ApplicationController
  protect_from_forgery with: :null_session

  def create

    if request.env["omniauth.auth"].present?
      user = User.find_or_create_by_omniauth(email: request.env["omniauth.auth"]['info']['email'])
      if user.id.present?
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "You have successfully logged in"
      else
        user.name = request.env["omniauth.auth"]['info']['name']
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.password = SecureRandom.hex
        user.save
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "You have successfully logged in"
      end
    end

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
