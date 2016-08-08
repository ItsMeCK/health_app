class Ride < ActiveRecord::Base
	has_many :users, through: :user_rides
	has_many :user_rides
	#serialaizer
	serialize :assembly_time
	serialize :destination_time
	serialize :check_points


	after_create :create_user_ride

	private

	def create_user_ride
		@users = User.all
		@users.each do |user|
			self.user_rides.create(ride_id: self.id, user_id: user.id, perticipate_ride: "Not Replied", user_ride_date: self.ride_date)
		end
	end
end
