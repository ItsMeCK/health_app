class Mobile::V1::UserRidesController < ApplicationController
  #before_filter :authenticate_user!, only: [:get_ride_and_events]
  def get_ride_and_events
     rides = UserRide.where('extract(year  from user_ride_date) = ?', params[:year]).where('extract(month  from user_ride_date) = ?', params[:month])
     user_rides = rides.where(user_id: params[:user_id])
     user_rides_response = user_rides.collect { |ride| ride if Ride.exists?(ride.ride_id)}.compact

     events = UserEvent.where('extract(year  from user_event_date) = ?', params[:year]).where('extract(month  from user_event_date) = ?', params[:month])
     user_events = events.where(user_id: params[:user_id])
     user_event_response = user_events.collect { |event| event if Event.exists?(event.event_id)}.compact

     @ride_events = {rides: user_rides_response}.merge({events: user_event_response})

     render json: @ride_events
  end

end
