class Mobile::V1::UserRidesController < ApplicationController
  #before_filter :authenticate_user!, only: [:get_ride_and_events]
  def show
    render json: UserRide.find(params[:id])
  end

  def get_ride_and_events
    ride = Ride.where('extract(year  from ride_date) = ?', params[:year]).where('extract(month  from ride_date) = ?', params[:month]).pluck(:id)
    user_ride = UserRide.where(ride_id: ride, user_id: params[:user_id])
    events = Event.where('extract(year  from event_date) = ?', params[:year]).where('extract(month  from event_date) = ?', params[:month]).pluck(:id)
    user_event = UserEvent.where(event_id: events, user_id: params[:user_id])
    
    past_rides = Ride.where('ride_date <= ?', current_user.created_at)
    past_events = Event.where('event_date <= ?', current_user.created_at)
    @ride_events = {rides: user_ride}.merge({events: user_event}).merge({past_rides: past_rides}).merge({past_events: past_events})
    render json: @ride_events
  end

end
