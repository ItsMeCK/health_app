class Mobile::V1::UserRidesController < ApplicationController
  #before_filter :authenticate_user!, only: [:get_ride_and_events]
  def get_ride_and_events
     rides = UserRide.where('extract(year  from user_ride_date) = ?', params[:year]).where('extract(month  from user_ride_date) = ?', params[:month])
     user_rides = rides.where(user_id: params[:user_id])
     events = UserEvent.where('extract(year  from user_event_date) = ?', params[:year]).where('extract(month  from user_event_date) = ?', params[:month])
     user_events = events.where(user_id: params[:user_id])
     @ride_events = {rides: user_rides}.merge({events: user_events})

     render json: @ride_events
  end

end
