class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def index
    @categories = Category.all
  end

  def show
    @habits = @category.habits
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.where(category_params).first_or_initialize do |c|
      if authorize c
        c.name = category_params[:name]
        c.save
      else
        flash[:error] = "You are not authorised to create a new category"
      end
    end
    redirect_to categories_path
  end

  def edit
  end

  def update
      if authorize @category
        @category.update(category_params)
        flash[:notice] = "'#{@category.name.capitalize}' category has been updated."
      else
        flash[:error] = "You are not authorised to update #{@category.name} category."
      end
    redirect_to categories_path
  end

  def destroy
    authorize @category
    @category.destroy
    redirect_to categories_path, notice: "'#{@category.name.capitalize}' category has been deleted."
  end

  private

  def set_category
    @category = Category.find_by(id: params[:id])
  end

  def category_params
    params.required(:category).permit(:name)
  end

  def set_user
    @user = User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
