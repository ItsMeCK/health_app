class MyBike < ActiveRecord::Base
	belongs_to :user
	belongs_to :default_bike_image
	has_many :service_bookings
	has_many :service_histories
	mount_base64_uploader :bike_image, ImageUploader, file_name: 'my_bike'

	#before_update :remove_old_image_assign_new

	 def service_history
    	self.service_histories
    end

	def as_json(options={})
		super.as_json(options).merge({:service_histories => service_history})
	end

		private

		def remove_old_image_assign_new
			self.remove_bike_image! if self.bike_image.present?
		end
	end
