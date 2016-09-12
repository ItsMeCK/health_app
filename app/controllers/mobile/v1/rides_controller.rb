class Mobile::V1::RidesController < ApplicationController

	def show
		render json: Ride.find(params[:id])
	end


	def user_responce_with_ride
		@user_ride = UserRide.find(params[:id])
		if params[:status] == "Yes"
			@user_ride.update(perticipate_ride: "Yes")
		elsif params[:status] == "No"
			@user_ride.update(perticipate_ride: "No")
		elsif params[:status] == "Maybe"
			@user_ride.update(perticipate_ride: "Maybe")
		else
			@user_ride
		end
		render json: @user_ride
	end

	def user_rides_information
		@user = User.find(params[:user_id])

		@user_accept = @user.user_rides.where(perticipate_ride:"Yes").collect { |user_ride| Ride.find(user_ride.ride_id) }
		@user_not_intrested = @user.user_rides.where(perticipate_ride:"No").collect { |user_ride| Ride.find(user_ride.ride_id) }
		@user_with_may_be = @user.user_rides.where(perticipate_ride:"Maybe").collect { |user_ride| Ride.find(user_ride.ride_id) }
		@not_replied = @user.user_rides.where(perticipate_ride:"Not Replied").collect { |user_ride| Ride.find(user_ride.ride_id) }

		@user_ride_response = {participated: @user_accept, not_participated: @user_not_intrested, may_be: @user_with_may_be, not_replay: @not_replied}

		render json: @user_ride_response
	end

	def ride_with_user_information
		@ride = Ride.find(params[:ride_id])

		@ride_accept_users = @ride.user_rides.where(perticipate_ride:"Yes").collect { |ride_user| User.find(ride_user.user_id) } 
		@ride_not_accept_users = @ride.user_rides.where(perticipate_ride:"No").collect { |ride_user| User.find(ride_user.user_id) }
		@ride_may_be_users = @ride.user_rides.where(perticipate_ride:"Maybe").collect { |ride_user| User.find(ride_user.user_id) }
		@ride_not_replied_users = @ride.user_rides.where(perticipate_ride:"Not Replied").collect { |ride_user| User.find(ride_user.user_id) }     

		@ride_with_user_responce = {participated_users: @ride_accept_users, not_participated_users:  @ride_not_accept_users, may_be_users: @ride_may_be_users, not_replayed_users: @ride_not_replied_users}

		render json: @ride_with_user_responce
	end
end