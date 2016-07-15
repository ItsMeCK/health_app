class MyBike < ActiveRecord::Base
	belongs_to :user
	has_many :service_bookings
	mount_base64_uploader :bike_image, ImageUploader, file_name: 'my_bike'
end
