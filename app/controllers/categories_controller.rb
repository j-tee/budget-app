class CategoriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @categories = Category.all.where(user_id: current_user.id)
  end

  def new
    @category = Category.new
    respond_to do |format|
      format.html { render :new, locals: { category: @category } }
    end
  end

  def create
    @user = current_user
    @category = Category.new(params.require(:new_category).permit(:name, :icon))
    @category.user = @user
    if @category.save
      flash[:notice] = 'Category created successfully!'
      redirect_to categories_path
    else
      flash[:alert] = @category.errors.full_messages.join(', ')
      redirect_to new_category_path, locals: { category: @category }
    end
  end

  private

  def category_params
    params.require(:new_category).permit(:name, :icon)
  end
end
