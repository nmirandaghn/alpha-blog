class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :set_category, only: [:show, :edit, :update]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'New category created succesfully'
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def edit    
  end

  def update
    if @category.update(category_params)
      flash[:success] = 'Category was succesfully updated'
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  def show
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    return if logged_in? && current_user.admin?
    flash[:danger] = 'Only admins can perform this action'
    redirect_to categories_path
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
