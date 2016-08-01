class BikeColor < ActiveRecord::Base
	belongs_to :bike

	#mount_base64_uploader :image, ImageUploader, file_name: 'bike_color'

	def bike_type
	    Bike.find_by_id(self.bike_id).name
	end

	def as_json(options={})
		super.as_json(options).merge({ :bike_name => bike_type })
	end

end
