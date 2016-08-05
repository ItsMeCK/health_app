Rails.application.routes.draw do
	
  devise_for :users
  # API Definition
  #API for password reset common for both web and mob
  post '/update_passwords' => 'devise/passwords#update_password'
  namespace :web, defaults: { format: :json }, path: '/web/' do
    scope module: :v1 do
    # We are going to list our resources here
    	resources :users, :only => [:create, :show, :update, :destroy, :index]
      resources :sessions, :only => [:create, :destroy]
      resource :api_token
      resources :profiles
      post '/profile_image_update' => 'profiles#profile_image_update'
      resources :hog_registrations
      post '/hog_registration_image_update' => 'hog_registrations#hog_registration_image_update'
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
      post '/my_bike_image_update' => 'my_bikes#my_bike_image_update'
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
      post '/update_accessory_image' => 'accessories#update_accessory_image'
      get '/get_accessories_enquiries' => 'accessories#get_accessories_enquiries'
      resources :accessory_categories
      post '/update_accessory_categery_image' => 'accessories#update_accessory_categery_image'
      resources :events
      resources :rides
      resources :my_docs
      post '/my_docs_image_update' => 'my_docs#my_docs_image_update'
      resources :email_notification_templates
      resources :notification_templates
      #get all categories
      # get '/get_notification_category' => 'notification_templates#notification_category'
      # get '/get_email_notification_category' => 'email_notification_templates#email_template_category'
      resources :dealer_types
      resources :dealers
      post '/dealers_image_update' => 'dealers#dealers_image_update'
      resources :set_booking_numbers
      resources :finance_documents
      resources :tenures
      resources :banners
      post '/update_image' => 'banners#update_image'
      resources :service_schedules
      resources :set_rules
      resources :notification_categories
      resources :service_histories
      post '/update_service_history_image' => 'service_histories#update_service_history_image'
      resources :default_bike_images
      resources :set_mails
      resources :service_numbers
      resources :contact_numbers
      resources :passwords, only: [:create]
      resources :dealer_contact_labels
      resources :dealer_contact_numbers
      resources :contact_types

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
      post '/update_profile_image' => 'profiles#update_profile_image'
      resources :hog_registrations, :except => [:delete]
      post '/update_hog_registration_image' => 'hog_registrations#update_hog_registration_image'
      resources :bike_types, :only => [:show, :index]
      resources :bikes, :only => [:show, :index]
      post '/bike_filter' => 'bikes#bike_filter'
      resources :specifications, :only => [:show, :index]
      resources :specification_types, :only => [:show, :index]
      resources :test_rides, :except => [:index]
      resources :service_bookings, :except => [:index]
      post '/my_bookings' => 'service_bookings#my_bookings'
      resources :my_bikes
      post '/update_my_bike_image' => 'my_bikes#update_my_bike_image'
      resources :feedbacks, only: [:create]
      resources :insurance_renewals, only: [:create, :show]
      resources :enquiries, only: [:create]
      post '/find_book_time_controls' => 'booking_time_controls#find_book_time_controls'
      resources :my_docs
      post '/update_my_docs_image' => 'my_docs#update_my_docs_image'
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
      post '/service_schedules_with_bike' => 'service_schedules#service_schedules_with_bike'
      post '/get_accessories' => 'accessory_categories#get_accessories'
      post '/accessories_enquiry' => 'accessory_categories#accessories_enquiry'
      resources :service_histories, :except => [:index]
      post '/my_bike_service_histories' => 'service_histories#get_my_bike_service_histories'
      post '/service_history_image_update' => 'service_histories#service_history_image_update'
      #getting ride and events based on month and year
      post '/get_ride_and_events' => 'user_rides#get_ride_and_events'
      post '/get_ride_status' => 'service_histories#get_ride_status'
      post '/get_event_status' => 'service_histories#get_event_status'
      resources :rides
      post '/user_responce_with_ride' => 'rides#user_responce_with_ride'
      post '/user_rides_information' => 'rides#user_rides_information'
      post '/ride_with_user_information' => 'rides#ride_with_user_information'
      resources :events
      post '/user_responce_with_event' => 'events#user_responce_with_event'
      post '/user_events_information' => 'events#user_events_information'
      post '/event_with_user_information' => 'events#event_with_user_information'
      resources :contact_numbers, only: [:index, :show]
      resources :passwords, only: [:create]

    end
  end

end