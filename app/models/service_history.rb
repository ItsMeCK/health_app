class ServiceHistory < ActiveRecord::Base
	belongs_to :my_bike
	mount_base64_uploader :bill_image, ImageUploader, file_name: 'service_history'

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			service_history = find_by_id(row["id"]) || new
			service_history.attributes = row.to_hash
			service_history.save!
		end
	end

end
