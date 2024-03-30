class SessionsController < ApplicationController

  # Renders the Login page by this action
  #
  # @return [void]
  def new; end

  # Creates a session (logs the user in and sets the session[:user_id] = user.id)
  #
  # @return [void]
  def create
    # render 'new'
    # debugger

    # find the User by the parameters entered by the users in the params Hash
    user = User.find_by(email: params[:session][:email].downcase)
    # if user Object is set then the password is authenticated using the
    # user.authenticate(password) methods
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = 'Log in Successful'
      # redirects to the authenticated users profile page
      redirect_to user_path(user)
    else
      # if failed then the error message is displayed and new form is renderd again
      flash.now[:danger] = 'Something went wrong with the login request!!'
      render 'new'
    end
  end

  # Destroyes/ logs the user out
  #
  # @return [void]
  def destroy
    # set session to nil
    session[:user_id] = nil
    flash[:success] = 'Successfully Logged out!'
    # redirect to the (home page) root route
    redirect_to root_path
  end

end
