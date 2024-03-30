class CategoriesController < ApplicationController

  # To perform the restfull operations user should be an admin
  before_action :require_admin, except: %i[index show]

  # Renders the create new category form with @user new instance of Category
  #
  # @return [void]
  def new
    @category = Category.new
  end

  # List all the categories
  #
  # @return [void]
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  # renders the specific category articles_list
  #
  # @return [void]
  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  # Create new categpry and save to the persistent data
  #
  # @return [void]
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category was successfully created'
      redirect_to @category
    else
      render 'new'
    end
  end

  # Render the edit category name form
  #
  # @return [void]
  def edit
    @category = Category.find(params[:id])
  end

  # Save to the persistent data
  #
  # @return [void]
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = 'Category name was successfully updated'
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  private

  # Sets the parameters for the category nane
  #
  # @return [void]
  def category_params
    params.require(:category).permit(:name)
  end

  # This check for the user is an admin or not, if admin then return else set flash
  # as the message and pass to the next request i.e /categories
  # @return [<Type>] <description>
  def require_admin
    return if logged_in? && current_user.admin?

    flash[:alert] = 'Only admins can perform this action'
    redirect_to categories_path
  end

end
