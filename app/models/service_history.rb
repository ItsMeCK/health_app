class ServiceHistory < ActiveRecord::Base
	belongs_to :my_bike
	mount_base64_uploader :bill_image, ImageUploader, file_name: 'service_history'
end
