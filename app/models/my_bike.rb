class MyBike < ActiveRecord::Base
	belongs_to :user
	belongs_to :default_bike_image
	has_many :service_bookings
	has_many :service_histories
	mount_base64_uploader :bike_image, ImageUploader, file_name: 'my_bike'
    
    #call backs
	#before_update :remove_old_image_assign_new
	after_create :create_bike_id
	
	def km_exceeds_for_months
		date1 = Date.today
		date2 = purchase_date
		purchased_month = (date2.year * 12 + date2.month) - (date1.year * 12 + date1.month)
		bike = Bike.find_by_name(bike)
		service_schedule = bike.service_schedules.where("purchased_month <= months").first
		return true if service_schedule.total_kms <= kms

	end	

	def service_history
		self.service_histories
	end

	def user_email
		self.user.try(:email)
	end

	def as_json(options={})
		super.as_json(options).merge({:service_histories => service_history, :user_mail => user_email})
	end
	
	private

	def create_bike_id
		bikes = Bike.all
		#bike_id = bikes.collect { |bike| bike if bike.name == self.bike }
		bike = Bike.find_by_name(self.bike)
		bike_image = bike.default_bike_image.try(:image_url)
		default_image = DefaultBikeImage.last.image_url
		if bike.present?
			self.update(bike_id: bike.id, my_bike_image_url: bike_image)
		else
			self.update(bike_id: 1, my_bike_image_url: default_image)
		end
	end

	# def create_my_bike_image_url
	# 	binding.pry
	# 	bike_images = DefaultBikeImage.all
	# 	bike_id = bike_images.collect { |bike_image| bike_image.image_url if bike_image.bike.name == self.bike }
	# 	binding.pry
	# 	if bike_id.present?
	# 		self.update(my_bike_image_url: bike_id)
	# 	else
	# 		self.update(bike_id: 1)
	# 	end
	# end

	def remove_old_image_assign_new
		self.remove_bike_image! if self.bike_image.present?
	end

end
