class Pricing < ActiveRecord::Base
	belongs_to :bike
	belongs_to :price_field


	def price_field_type
		 PriceField.find_by_id(self.price_field_id).name
	end

	def bike_type
	    Bike.find_by_id(self.bike_id).try(:name)
	end

	def as_json(options={})
		super.as_json(options).merge({ :bike_name => bike_type, :price_field_type => price_field_type })
	end
end
