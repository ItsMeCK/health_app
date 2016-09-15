class ServiceBooking < ActiveRecord::Base
	audited
	belongs_to :my_bike

	def my_bike_name
		if MyBike.exists?(self.my_bike_id)
			MyBike.find_by_id(self.my_bike_id).try(:bike) || "null"	
		end
	end

	def user_name
		if MyBike.exists?(self.my_bike_id) && MyBike.find_by_id(self.my_bike_id).user.present?
			MyBike.find_by_id(self.my_bike_id).user.profile.try(:full_name) || "null"	
		end
	end

	def user_mobile
		if MyBike.exists?(self.my_bike_id) && MyBike.find_by_id(self.my_bike_id).user.present?
			  MyBike.find_by_id(self.my_bike_id).user.profile.try(:mobile) || "null"	
		end
	end

	def user_email
		if MyBike.exists?(self.my_bike_id) && MyBike.find_by_id(self.my_bike_id).user.present?
			MyBike.find_by_id(self.my_bike_id).user.email || "null"	
		end
	end

	def sevice_booking_notification(n_template, dealer_mail_template, customer_mail_template)
		template = NotificationTemplate.where(category: n_template).last
		user = self.my_bike.user
        Notification.create(recipient: user, actor: user, action: 'Bookings', notifiable: self, notification_template: template)
        # mail to admin
        UserMailer.service_booking(self, dealer_mail_template).deliver
       # mail to confirm user
        UserMailer.service_request_confirm(self, customer_mail_template).deliver
	end	
	
	def as_json(options={})
		super.as_json(options).merge({:my_bike_name => my_bike_name, :user_name => user_name, :user_mobile => user_mobile, :user_email => user_email})
	end

end
