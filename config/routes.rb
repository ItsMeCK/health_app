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
      resources :my_bikes
      resources :feedbacks, only: [:index, :show, :create]
      resources :insurance_renewals, except: [:delete]
      resources :enquiries, except: [:delete]
      resources :booking_time_controls
      resources :key_feature_types
      resources :key_features
      resources :price_fields
      resources :pricings
      resources :bike_colors
      resources :accessories
      resources :accessory_categories
      resources :events
      resources :rides
      resources :my_docs
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
      post '/my_bookings' => 'service_bookings#my_bookings'
      resources :my_bikes
      resources :feedbacks, only: [:create]
      resources :insurance_renewals, only: [:create, :show]
      resources :enquiries, only: [:create]
      post '/find_book_time_controls' => 'booking_time_controls#find_book_time_controls'
      resources :my_docs
    end
  end

end