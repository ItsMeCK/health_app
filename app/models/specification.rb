class Specification < ActiveRecord::Base
	belongs_to :specification_type
	belongs_to :bike

	def specification_type
		 SpecificationType.find_by_id(self.specification_type_id).name
	end

	def bike_type
	    Bike.find_by_id(self.bike_id).name
	end

	def as_json(options={})
		super.as_json(options).merge({ :bike_name => bike_type, :specifications_type => specification_type })
	end

end
