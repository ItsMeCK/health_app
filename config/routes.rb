Rails.application.routes.draw do
	

  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # API Definition
  #API for password reset common for both web and mob
  post '/update_passwords' => 'devise/passwords#update_password'
  resource :uploads
  #root 'uploads#upload_bikes'
  resource :uploads do
    collection { 
      post :import
      post :import_users
      post :import_service_history 
      post :import_prices 
      post :import_specifications
      post :import_key_features 
      post :import_colors
      post :import_service_schedules
    }
  end
  get '/upload_bikes' => 'uploads#upload_bikes'
  get '/upload_specifications' => 'uploads#upload_specifications'
  get '/upload_users' => 'uploads#upload_users'
  get '/upload_service_history' => 'uploads#upload_service_history'
  get '/upload_prices' => 'uploads#upload_prices'
  get '/upload_key_features' => 'uploads#upload_key_features'
  get '/upload_colors' => 'uploads#upload_colors'
  get '/upload_service_schedules' => 'uploads#upload_service_schedules'
  namespace :web, defaults: { format: :json }, path: '/web/' do
    scope module: :v1 do
    # We are going to list our resources here
    resources :accessory_tags
    resources :tags
    resources :users, :only => [:create, :show, :update, :destroy, :index]
    post '/delete_users' => 'users#delete_users'
    post '/get_my_bikes' => 'users#get_my_bikes'
    resources :sessions, :only => [:create, :destroy]
    resource :api_token
    resources :profiles
    #audits
    get '/audit_lgs' => 'audit#audit_logs'
    post '/delete_profiles' => 'profiles#delete_profiles'
    post '/profile_image_update' => 'profiles#profile_image_update'
    resources :hog_registrations
    post '/delete_hog_registrations' => 'hog_registrations#delete_hog_registrations'
    post '/hog_registration_image_update' => 'hog_registrations#hog_registration_image_update'
    resources :bike_types
    post '/delete_bike_types' => 'bike_types#delete_bike_types'
    resources :bikes
    get '/get_all_bikes' => 'bikes#get_all_bikes'
    post '/delete_all_bikes' => 'bikes#delete_bikes'
    resources :specifications
    post '/delete_specifications' => 'specifications#delete_specifications'
    resources :specification_types
    post '/delete_specification_types' => 'specification_types#delete_specification_types'
    resources :test_rides
    post '/delete_test_rides' => 'test_rides#delete_test_rides'
      #api for the admin dashboard all bookings
      post '/get_all_bookings' => 'test_rides#all_bookings'
      post '/bookings_with_day' => 'test_rides#bookings_with_day'
      post '/bookings_with_count' => 'test_rides#bookings_with_count'
      post '/get_bookings_by_period' => 'dashboards#bookings_by_period'

      resources :service_bookings
      post '/delete_service_bookings' => 'service_bookings#delete_service_bookings'
      resources :my_bikes
      post '/delete_my_bikes' => 'my_bikes#delete_my_bikes'
      post '/my_bike_image_update' => 'my_bikes#my_bike_image_update'
      resources :feedbacks, only: [:index, :show, :create]
      resources :insurance_renewals, except: [:delete]
      post '/delete_insurance_renewals' => 'insurance_renewals#delete_insurance_renewals'
      resources :enquiries, except: [:delete]
      resources :booking_time_controls
      post '/delete_booking_time_controls' => 'booking_time_controls#delete_booking_time_controls'
      resources :key_feature_types
      post '/delete_key_feature_types' => 'key_feature_types#delete_key_feature_types'
      resources :key_features
      post '/delete_key_features' => 'key_features#delete_key_features'
      resources :price_fields
      post '/delete_price_fields' => 'price_fields#delete_price_fields'
      resources :pricings
      post '/delete_pricings' => 'pricings#delete_pricings'
      resources :bike_colors
      post '/delete_bike_colors' => 'bike_colors#delete_bike_colors'
      resources :accessories
      post '/delete_accessories' => 'accessories#delete_accessories'
      post '/update_accessory_image' => 'accessories#update_accessory_image'
      get '/get_accessories_enquiries' => 'accessories#get_accessories_enquiries'
      resources :accessory_categories
      post '/delete_accessory_categories' => 'accessory_categories#delete_accessory_categories'
      post '/update_accessory_categery_image' => 'accessories#update_accessory_categery_image'
      resources :events
      post '/delete_events' => 'events#delete_events'
      post '/user_with_event_information' => 'events#user_event_inforamtion'
      resources :rides
      post '/delete_rides' => 'rides#delete_rides'
      post '/user_with_ride_information' => 'rides#user_inforamtion'
      resources :my_docs
      post '/delete_my_docs' => 'my_docs#delete_my_docs'
      post '/my_docs_image_update' => 'my_docs#my_docs_image_update'
      resources :email_notification_templates
      post '/delete_email_notification_templates' => 'email_notification_templates#delete_email_notification_templates'
      resources :notification_templates
      post '/delete_notification_templates' => 'notification_templates#delete_notification_templates'
      #get all categories
      # get '/get_notification_category' => 'notification_templates#notification_category'
      # get '/get_email_notification_category' => 'email_notification_templates#email_template_category'
      resources :dealer_types
      post '/delete_dealer_types' => 'dealer_types#delete_dealer_types'
      resources :dealers
      post '/delete_dealers' => 'dealers#delete_dealers'
      post '/dealers_image_update' => 'dealers#dealers_image_update'
      resources :set_booking_numbers
      resources :finance_documents
      post '/delete_finance_documents' => 'finance_documents#delete_finance_documents'
      resources :tenures
      post '/delete_tenures' => 'tenures#delete_tenures'
      resources :banners
      post '/delete_banners' => 'banners#delete_banners'
      post '/update_image' => 'banners#update_image'
      resources :service_schedules
      post '/delete_service_schedules' => 'service_schedules#delete_service_schedules'
      resources :set_rules
      post '/delete_set_rules' => 'set_rules#delete_set_rules'
      resources :notification_categories
      post '/delete_notification_categories' => 'notification_categories#delete_notification_categories'
      resources :service_histories
      post '/delete_service_histories' => 'pricings#delete_service_histories'
      post '/update_service_history_image' => 'service_histories#update_service_history_image'
      resources :default_bike_images
      post '/delete_default_bike_images' => 'pricings#delete_default_bike_images'
      resources :set_mails
      post '/delete_set_mails' => 'set_mails#delete_set_mails'
      resources :service_numbers
      post '/delete_service_numbers' => 'service_numbers#delete_service_numbers'
      resources :contact_numbers
      post '/delete_contact_numbers' => 'contact_numbers#delete_contact_numbers'
      resources :passwords, only: [:create]
      resources :dealer_contact_labels
      post '/delete_dealer_contact_labels' => 'dealer_contact_labels#delete_dealer_contact_labels'
      resources :dealer_contact_numbers
      post '/delete_dealer_contact_numbers' => 'dealer_contact_numbers#delete_dealer_contact_numbers'
      resources :contact_types
      post '/delete_contact_types' => 'contact_types#delete_contact_types'
      resources :notification_counts
      post '/delete_notification_counts' => 'notification_counts#delete_notification_counts'
      post '/create_bulk_notification' => 'notifications#create_bulk_notification'
      resources :notifications 
      post '/delete_notifications' => 'notifications#delete_notifications'
      #bike gallery
      resources :galleries
      post '/delete_galleries' => 'galleries#delete_galleries'
      #post '/get_document' => 'finance_documents#get_document'
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
    #validate my docs
    post '/validate_my_docs' => 'my_docs#validate_document_name'
    post '/update_my_docs_image' => 'my_docs#update_my_docs_image'
    resources :dealer_types, :only => [:show]
    get '/get_dealers_with_contact_numbers' => 'dealers#dealer_contact_numbers'
    resources :dealers, :only => [:index, :show]
    resources :finance_documents, :only => [:show]
    resources :tenures, :only => [:index, :show]
    resources :accessory_categories, only: [:index, :show]
    post '/accessories_with_brand' => 'accessory_categories#accessories_with_brand'
    resources :set_booking_numbers, only: [:index, :show]
    post '/booking_numbers_with_category' => 'set_booking_numbers#find_by_category'
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
      post '/get_contact_numbers' => 'contact_numbers#get_contact_numbers'
      resources :passwords, only: [:create]
      #Api for user nitification count
      post '/notification_count' => 'users#notification_count'
      post '/clear_notification_count' => 'users#clear_notification_count'
      post '/notification_by_category' => 'users#notification_by_category'
      resources :notifications
      get '/mark_as_read/:id' => 'notifications#mark_as_read'
      post '/email_document' => 'finance_documents#email_document'
      post '/get_document' => 'finance_documents#get_document'

      resources :user_events
      resources :user_rides
      resources :accessory_tags
      resources :tags
      resources :accessories

    end
  end

end