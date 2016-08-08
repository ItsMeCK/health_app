class MyBike < ActiveRecord::Base
	belongs_to :user
	belongs_to :default_bike_image
	has_many :service_bookings
	has_many :service_histories
	mount_base64_uploader :bike_image, ImageUploader, file_name: 'my_bike'

	#before_update :remove_old_image_assign_new

	def km_exceeds_for_months
		date1 = Date.today
		date2 = purchase_date
		purchased_month = (date2.year * 12 + date2.month) - (date1.year * 12 + date1.month)
		bike = Bike.find_by_name(bike)
		service_schedule = bike.service_schedules.where("purchased_month <= months").first
		return true if service_schedule.total_kms <= kms
	end	

	private

	def remove_old_image_assign_new
		self.remove_bike_image! if self.bike_image.present?
	end
end
