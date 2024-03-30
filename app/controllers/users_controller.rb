# controller to handle users resources actions
class UsersController < ApplicationController

  # a filter method used tio  controls the action
  # these methods can halt the requests and
  # these methods run before performing the mentioned actions in the only array
  before_action :set_user, only: %i[edit update show]

  # performs a check before performing actions edit and update that the user is
  # the profiles user is same as the user logged in
  before_action :require_same_user, only: %i[edit update]

  # actions to  perform if the logged_in? user is a admin
  before_action :require_admin, only: [:destroy]

  # Renders the List of users with max 5 users per page
  #
  # @return [void]
  def index
    # using the paginate method provided by the will paginate
    # has parameters page and per_page, page and the limit of the page
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  # new action to create a new user - renders the new form for user registration

  # Renders the new template
  #
  # @return [User]
  def new
    @user = User.new
  end

  # this action is invoked when the user clicks the sign up button in the form

  # Submits the data to the database
  #
  # @return [void]
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      # set flash success to success message
      flash[:success] = "Welcome to the NeutronBlog #{@user.username}"
      # redirect to the the articles index page from here
      redirect_to user_path(@user)
    else
      # if the user is not saves successfully then the new page is rendered
      # with the error messages form the user.errors.full_messages
      # and try again by correcting the inputs
      render 'new'
    end
  end

  # Assigned the user object to @user and Renders the show page for User
  # The show view displays the user information like the profile image(here the gravatar image)
  # and the articles created by that user only
  # route for show is : articles/:id

  # Renders the show template for a particular view
  #
  # @return [User]
  def show
    # the set_user is executed before entering this method
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  # Edit an existing user by :id
  #
  # @return [User]
  def edit
    # find the object by :id and assign to an instance @user
    # the set_user is executed before entering this method
  end

  # updates the existing user with the nee input data
  #
  # @return [void]
  def update
    # the set_user is executed before entering this method
    # find the user object by :id and assign it to the @user instance
    # if updated successfully the success flash is updated
    # else edit is rendered with errors and user data
    if @user.update(user_params)
      flash[:success] = 'Your account was updated successfully'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  # Destroy the user and the articles he has posted
  #
  # @return [void]
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = 'User and all articles created by user have been successfully deleted.'
    redirect_to users_path
  end

  private

  # Check whether the current user is an admin or not if not then display the respective error message
  # also check whether the user is not an admin also
  #
  # @return [void]
  def require_admin
    return unless current_user == @user && current_user.admin?

    flash[:danger] = 'Only admin can perform that action'
    redirect_to root_path
  end

  # this method is used to check whether the user logged in is the same user if the
  # profiles user else prints the error message
  def require_same_user
    return unless logged_in? && current_user != @user

    flash[:danger] = 'You can only edit your own account.'
    redirect_to root_path
  end

  # sets the current user to an instance @user
  def set_user
    @user = User.find(params[:id])
  end

  # white list all the attributes from the new view to save them into the database
  #
  # @return [Hash]
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
