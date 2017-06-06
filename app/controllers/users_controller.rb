class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # before_filter :skip_password_attribute, only: :change_role

  def index
    @users = User.all
    unless authorize @users
      redirect_to '/', notice: 'Only moderator can view this page.'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = 2
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def show
    authorize @user
  end

  def edit
  end

  def update
    if authorize @user
      if @user.authenticate(params[:user][:old_password])
        if @user.update(user_params)
          redirect_to @user, notice: 'User was successfully updated.'
        else
          render :edit
        end
      else
        render :edit, notice: "Please enter a valid password to update your profile, #{@user.name}"
      end
    else
      redirect_to '/', notice: "You are not authorised to update profile of #{@user.name}"
    end
  end

  def destroy
    authorize @user
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  def change_role
    binding.pry
    @user = User.find_by(id: params[:id])
    @user.skip_password_validation = true
    if @user.email.present? && @user.name.present?
       @user.role = params[:role].to_i
       binding.pry
       @user.save!
      "#{@user.name} is now a #{@user.role}!"
    else
      "There was an issue with this request!"
    end
    redirect_to users_path
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def skip_password_attribute
    if params[:password].blank? && params[:password_validation].blank?
      params.except!(:password, :password_validation)
    end
  end
end
