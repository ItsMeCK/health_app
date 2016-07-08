class ServiceBooking < ActiveRecord::Base
	belongs_to :my_bike

	def my_bike_name
		MyBike.find(self.my_bike_id).bike if self.my_bike_id
	end

	def as_json(options={})
		super.as_json(options).merge({:my_bike_name => my_bike_name})
	end

end
