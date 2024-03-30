Rails.application.routes.draw do
  resources :tags
  # provides all routes required for the controllers actions(Article)
  # eg, /articles, /articles/new, /articles/:id/edit, etc
  resources :articles
  # Non-resourceful  routes for sessions controller

  # Sets route as /signup route instead of /new route for registering a new user
  get 'signup', to: 'users#new'
  # new login form route: GET method for creating a session as login
  get 'login', to: 'sessions#new'
  # login route POST method create the session
  post 'login', to: 'sessions#create'
  # delete route: DELETE method to logout destroy the session
  delete 'logout', to: 'sessions#destroy'

  # post 'users', to: 'users#create'  => only for one route of users resources
  # This method will add all the routes for the users resources except the new action
  resources 'users', except: %i[new]

  # connects the 'pages/home' URL to the Controller pages

  # set the default or root page to render (root route)
  # when we go to 'http://localhost:3000/'
  root 'pages#home'

  # connects the 'pages/about' URL to the Controller pages
  # further to action about
  get 'pages/about', to: 'pages#about'

  # create resourc full routes fot the categories resource except the destroy action
  resources :categories, except: [:destroy]
end
