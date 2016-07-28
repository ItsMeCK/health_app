class DefaultBikeImage < ActiveRecord::Base
	belongs_to :bike
	has_many :my_bikes

	def bike_name
		Bike.find(self.bike_id).name
	end

	def as_json(options={})
		super.as_json(options).merge({:bike_name => bike_name})
	end
end
