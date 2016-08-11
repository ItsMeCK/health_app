class BikeColor < ActiveRecord::Base
	belongs_to :bike

	#mount_base64_uploader :image, ImageUploader, file_name: 'bike_color'

	def bike_type
	    Bike.find_by_id(self.bike_id).name
	end

	def as_json(options={})
		super.as_json(options).merge({ :bike_name => bike_type })
	end

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			bike_colors = find_by_id(row["id"]) || new
			bike_colors.attributes = row.to_hash
			bike_colors.save!
		end
	end

end
