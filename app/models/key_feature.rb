class KeyFeature < ActiveRecord::Base
	belongs_to :bike
	belongs_to :key_feature_type
	#mount_base64_uploader :image, ImageUploader, file_name: 'key_feature'

	def key_feature_type
		 KeyFeatureType.find_by_id(self.key_feature_type_id).try(:feature_type_name)
	end

	def bike_type
	    Bike.find_by_id(self.bike_id).try(:name)
	end

	def as_json(options={})
		super.as_json(options).merge({ :bike_name => bike_type, :key_feature_type => key_feature_type })
	end

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			key_features = find_by_id(row["id"]) || new
			key_features.attributes = row.to_hash
			key_features.save!
		end
	end

end
