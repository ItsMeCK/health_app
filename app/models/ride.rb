class Ride < ActiveRecord::Base
	has_many :users, through: :user_rides
	has_many :user_rides

	after_create :create_user_ride

	private

	def create_user_ride
		@users = User.all
		@users.each do |user|
			self.user_rides.create(ride_id: self.id, user_id: user.id, perticipate_ride: "Not Replied")
		end
	end
end
