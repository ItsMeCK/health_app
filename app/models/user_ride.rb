class UserRide < ActiveRecord::Base
	belongs_to :user
	belongs_to :ride

	def ride_route
		self.ride.ride_date
	end
	def ride_distance
		self.ride.distance
	end
	def ride_location
		self.ride.assembly_location
	end
	def ride_destination_location
		self.ride.destination_location
	end
	def assembly_time
		self.ride.assembly_time
	end
	def title
		self.ride.title
	end
	def destination_time
		self.ride.destination_time
	end
	def check_points
		self.ride.check_points
	end


	def as_json(options={})
		super(:only => [:id, :user_id, :ride_id, :perticipate_ride, :user_ride_date]).merge({:ride_title => title, :ride_route => ride_route, :ride_distance => ride_distance, :assembly_lacation => ride_location, :distination_location => ride_destination_location, :ride_assembly_time => assembly_time, :ride_distination_time => destination_time, :ride_check_points => check_points})
	end
end
