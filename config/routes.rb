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
      post '/delete_all_bikes' => 'bikes#delete_bikes'
      resources :specifications
      resources :specification_types
      resources :test_rides
      #api for the all bookings
      post '/get_all_bookings' => 'test_rides#all_bookings'
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
      get '/get_accessories_enquiries' => 'accessories#get_accessories_enquiries'
      resources :accessory_categories
      resources :events
      resources :rides
      resources :my_docs
      resources :email_notification_templates
      resources :notification_templates
      #get all categories
      # get '/get_notification_category' => 'notification_templates#notification_category'
      # get '/get_email_notification_category' => 'email_notification_templates#email_template_category'
      resources :dealer_types
      resources :dealers
      resources :set_booking_numbers
      resources :finance_documents
      resources :tenures
      resources :banners
      resources :service_schedules
      resources :set_rules
      resources :notification_categories
      resources :service_histories
      resources :default_bike_images

    end
  end

## ================= Below is Mobile API Routes ================= ##

  namespace :mobile, defaults: { format: :json }, path: '/mobile/' do
    scope module: :v1 do
    # We are going to list our resources here
    	resources :users, :only => [:create, :show, :update, :destroy]
      post '/update_wishlist_items' => 'users#update_wishlist_items'
      post '/get_wishlist_items' => 'users#get_wishlist_items'
      post '/remove_wishlist_items' => 'users#remove_wishlist_items'
      resources :sessions, :only => [:create, :destroy]
      resources :profiles, :except => [:delete]
      resources :hog_registrations, :except => [:delete]
      resources :bike_types, :only => [:show, :index]
      resources :bikes, :only => [:show, :index]
      post '/bike_filter' => 'bikes#bike_filter'
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
      resources :dealer_types, :only => [:show]
      resources :dealers, :only => [:show]
      resources :finance_documents, :only => [:show]
      resources :tenures, :only => [:show]
      resources :accessory_categories, only: [:index, :show]
      resources :set_booking_numbers, only: [:index, :show]
      post '/find_by_categopry' => 'set_booking_numbers#find_by_categopry'
      post '/my_bike_service_histories' => 'service_histories#get_my_bike_service_histories'
      resources :banners, only: [:index, :show]
      resources :service_schedules, only: [:index, :show]
      post '/get_accessories' => 'accessory_categories#get_accessories'
      post '/accessories_enquiry' => 'accessory_categories#accessories_enquiry'
      resources :service_histories, :except => [:index]
      post '/my_bike_service_histories' => 'service_histories#get_my_bike_service_histories'
      #getting ride and events based on month and year
      post '/get_ride_and_events' => 'service_histories#get_ride_and_events'
      post '/get_ride_status' => 'service_histories#get_ride_status'
      post '/get_event_status' => 'service_histories#get_event_status'

    end
  end

end