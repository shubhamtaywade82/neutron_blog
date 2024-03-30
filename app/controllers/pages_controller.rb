# class pages controller is the namespace 'pages/'
# I can contain more actions to be performed on the pages
class PagesController < ApplicationController

  # invoked when the URL requests is 'pages/home'
  def home
    # renders the home.html.erb
    # only display this page when not logged im
    redirect_to articles_path if logged_in?
  end

  # invoked when the URL requests is 'pages/about'
  def about
    # renders the about.html.erb
  end

end
