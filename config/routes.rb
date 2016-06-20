Rails.application.routes.draw do
	
  devise_for :users
  # API Definition
  namespace :web, defaults: { format: :json }, path: '/web/' do
    scope module: :v1 do
    # We are going to list our resources here
    	resources :users, :only => [:create, :show, :update, :destroy, :index]
      resources :sessions, :only => [:create, :destroy]
      resource :api_token
      resources :profiles, :except => [:edit, :new]
      resources :hog_registrations, :except => [:edit, :new]
      resources :bike_types
      resources :bikes
      resources :specifications
    end
  end

## ================= Below is Mobile API Routes ================= ##

  namespace :mobile, defaults: { format: :json }, path: '/mobile/' do
    scope module: :v1 do
    # We are going to list our resources here
    	resources :users, :only => [:create, :show, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
      resources :profiles, :except => [:edit, :new, :index]
      resources :hog_registrations, :except => [:edit, :new, :index]
      resources :bike_types, :only => [:show, :index]
      resources :bikes, :only => [:show, :index]
      resources :specifications, :only => [:show, :index]
    end
  end

end