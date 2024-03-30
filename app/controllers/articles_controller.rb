# Manages the Articles
class ArticlesController < ApplicationController

  # before actions work in order

  # a filter method used tio  controls the action
  # these methods can halt the requests and
  # these methods run before performing the mentioned actions in the only array
  before_action :set_article, only: %i[edit show update destroy]

  # Restrict the physical access through the url links
  # First set the user through the set_user then use the require_user to perform
  # the all actions expect mentioned these actions
  # we will require a user to perform the remaining operations(new, create, edit, update, destroy)
  before_action :require_user, expect: %i[index show]

  # Allow the users who have created the article to edit , :delete update actions
  before_action :require_same_user, only: %i[edit update destroy]

  # This action List creates an instance which stores all the Articles fetched
  # from the persistent database
  #
  # @return [Array<Articles>]
  def index
    # @articles = Article.all

    # performs a pagination here with per page only 5 articles
    @articles = Article.paginate page: params[:page], per_page: 5
    # @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  # UNDERSTANDING: The new action renders new form where we will be
  # entering the data ( title and description )

  # creates a new instance of the article to be added
  #
  # @return [void]
  #
  def new
    @article = Article.new
  end

  # This actions is invoked when the submit button here(Create Article) is
  # clicked this creates a new instance of the Article with the parameters
  # entered by the user in the new form
  # These parameters are whitelisted at first then the parameters hits the
  # database by using @article.save

  # UNDERSTANDING 108927 =
  # sets the success message if article gets saved in the database
  # else the new page is rendered again with empty fields

  # Creates a new instance with the parameters from the form
  #
  # @return [void]
  #
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    # For now hardcoded the user reference to the first user in the database

    # Render validation errors on form if resource is not saved due to invalid
    # data (which did not pass validations defined resource model)
    if @article.save
      flash[:notice] = 'Article Created Successfully'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  # UNDERSTANDING #108926 = (TASK 1)this action creates and instance for the Article
  # id requested by the user, this and the data is retrieved and sent to the
  # view through the @article instance, this persistent data is then edited
  # in the edit form and then when we hit the update article button the
  # update action is invoked

  # Action to edit the specific article
  #
  # @return [Article]
  def edit
    # (TASK 3) assigning the data by retrieving the persistent data using the :id
    # set_article runs before this methods are  executes
  end

  # UNDERSTANDING #108926 = (TASK 4)After editing the information retrieved  in the edit
  # form the edit update article button is clicked then this update action is
  # invoked this action sets a new instance with the updated information
  # this information is updated in the database using the update method
  # provided by the ActionController and data validation is performed through
  # models validate method

  # Action updates the existing data with the newly entered data
  #
  # @return [void]
  def update
    # set_article runs before this methods are  executes
    # (TASK 4)Collecting the data using params and whitelisting them so as to def update
    # that data into the persistent database
    if @article.update(article_params)
      # (TASK 6) Display the message for successfully updating the Article
      # using flash displayed on the show view of the article
      flash[:notice] = 'Article Updated Successfully!'
      # (TASK 6)After Successfully updating the article redirects to the articles show page
      # article_path is the method provided by the resources which accepts the
      # article instance as the argument +show+ (invokes the show action for id)
      redirect_to article_path(@article)
    else
      # (TASK 5)if the data edited is invalid the same page is rendered again with the
      # errors that is preventing the article from updating
      render 'edit'
    end
  end

  # Shows a specific article
  #
  # @return [Article]
  #
  def show
    # set_article runs before this methods are  executes
  end

  # the destroy action is invoked when the route is specified to the DELETE
  # Http method in this action the @article is assigned the article which
  # is to be deleted this article is then deleted using the destroy method
  # which runs the query for the database that is
  # "delete * from articles where id = @article.id"
  # if no error occurs an this hits the database it will display the success
  # message else some error in this case no error might occur as we are
  # deleting only the articles which are present in the list

  # Assigns a new instance the article to be deleted by finding it using the id
  #
  # @return [Article]
  def destroy
    # set_article runs before this methods are  executes
    @article.destroy
    flash[:notice] = 'Article Deleted Successfully!!'
    redirect_to articles_path
  end

  private

  # the user login and the user of the article must be same
  # Checks whether the user logged in and the articles owner and the current user are name
  # also checks whether the current user is a admin user or not

  # User is the owner of the articles or not
  #
  # @return [void]
  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:danger] = 'You can only delete or edit your own articles.'
      redirect_to root_path
    end
  end

  # Sets the @article to the article that is passed a params form the view
  #
  # @return [Article]
  def set_article
    @article = Article.find(params[:id])
  end

  # This method says that the parameters are required and the parameters are
  # the require method looks for params[:article] and raises error if not
  # present and  the permit method is a list of allowed but optional attributes.

  # whitelists the parameters for further process that is save to database
  #
  # @return [Hash]
  def article_params
    # whitelists the parameters from the view :title, description and :user_id
    params.require(:article).permit(:title, :description, category_ids: [], tags_ids: [])
  end

end
