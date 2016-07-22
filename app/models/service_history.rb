class ServiceHistory < ActiveRecord::Base
	belongs_to :bike
	mount_base64_uploader :bill_image, ImageUploader, file_name: 'service_history'
end
