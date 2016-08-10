class UserRide < ActiveRecord::Base
	belongs_to :user
	belongs_to :ride

	def ride_route
		self.ride.try(:ride_date)
	end
	def ride_distance
		self.ride.try(:distance)
	end
	def ride_location
		self.ride.try(:assembly_location)
	end
	def ride_destination_location
		self.ride.try(:destination_location)
	end
	def assembly_time
		self.ride.try(:assembly_time)
	end
	def title
		self.ride.try(:title)
	end
	def destination_time
		self.ride.try(:destination_time)
	end
	def check_points
		self.ride.try(:check_points)
	end

	def as_json(options={})
		super(:only => [:id, :user_id, :ride_id, :perticipate_ride, :user_ride_date]).merge({:ride_title => title, :ride_route => ride_route, :ride_distance => ride_distance, :assembly_location => ride_location, :destination_location => ride_destination_location, :ride_assembly_time => assembly_time, :ride_destination_time => destination_time, :ride_check_points => check_points})
	end
end
