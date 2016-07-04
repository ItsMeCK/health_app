Rails.application.routes.draw do
	
  devise_for :users
  # API Definition
  namespace :web, defaults: { format: :json }, path: '/web/' do
    scope module: :v1 do
    # We are going to list our resources here
    	resources :users, :only => [:create, :show, :update, :destroy, :index]
      resources :sessions, :only => [:create, :destroy]
      resource :api_token
      resources :profiles
      resources :hog_registrations
      resources :bike_types
      resources :bikes
      resources :specifications
      resources :specification_types
      resources :test_rides
      resources :service_bookings
    end
  end

## ================= Below is Mobile API Routes ================= ##

  namespace :mobile, defaults: { format: :json }, path: '/mobile/' do
    scope module: :v1 do
    # We are going to list our resources here
    	resources :users, :only => [:create, :show, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
      resources :profiles, :except => [:delete]
      resources :hog_registrations, :except => [:delete]
      resources :bike_types, :only => [:show, :index]
      resources :bikes, :only => [:show, :index]
      resources :specifications, :only => [:show, :index]
      resources :specification_types, :only => [:show, :index]
      resources :test_rides, :except => [:index]
      resources :service_bookings, :except => [:index]
    end
  end

end