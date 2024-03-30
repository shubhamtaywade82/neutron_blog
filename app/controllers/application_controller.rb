class ApplicationController < ActionController::Base

  # helper_methods are the code that can be used in
  #

  # This defines which methods are helper methods
  helper_method :current_user, :logged_in?, :administrator?

  # caching with an instance variable
  # This instance variable sticks around the single request
  # Memoization - Optimization technique used by the program to store the result
  # high cost function calls and returning the cached result when we try to so send the same request
  # cached memory

  # Finds the current logged in user if session is present
  #
  # @return [User]
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Checks whether the user is logged in or not
  #
  # @return [Boolean]
  def logged_in?
    !!current_user
  end

  # UI restriction is achieved using this method, only logged in users should
  # perform such tasks
  #
  # @return [void]
  def require_user
    return if logged_in?

    flash[:danger] = 'You must be logged in to perform that action'
    redirect_to root_path
  end

  # Checks if the current user is a admin or not
  #
  # @returns [Boolean]
  def administrator?(article)
    current_user == article.user || current_user.admin?
  end

end
