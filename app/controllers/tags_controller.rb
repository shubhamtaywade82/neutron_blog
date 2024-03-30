class TagsController < ApplicationController


  before_action :require_admin, except: %i[index show]
  # Adds a new Tag to the Blog
  #
  # @return [void]
  def new
    @tag = Tag.new
  end

  # Creates a Tag record
  #
  # @return [void]
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = 'Tag successfully created'
      redirect_to @tag
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  # Edits the Tag information
  #
  # @return [void]
  def edit
    @tag = Tag.find(params[:id])
  end

  # Updates the tag in the Blog with data
  #
  # @return [void]
  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      flash[:success] = 'Tag was successfully updated'
      redirect_to @tag
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  # Finds the {Articles} by Tag
  #
  # @return [void]
  def show
    @tag = Tag.find(params[:id])
  end

  private

  # @return [void]
  def require_admin
    return if logged_in? && current_user.admin?

    flash[:alert] = 'Only admins can perform this action'
    redirect_to tags_path
  end

  # Allow attributes that map to the database properties
  #
  # @return [void]
  def tag_params
    params.require(:tag).permit(:name)
  end
end
