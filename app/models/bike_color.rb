class BikeColor < ActiveRecord::Base
	belongs_to :bike

	def bike_type
	    Bike.find_by_id(self.bike_id).name
	end

	def as_json(options={})
		super.as_json(options).merge({ :bike_name => bike_type })
	end

end
