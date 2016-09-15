class TestRide < ActiveRecord::Base
	audited
	belongs_to :user

	def test_ride_booking_notification(n_template, dealer_mail_template, customer_mail_template)
		template = NotificationTemplate.where(category: n_template).last
	    Notification.create(recipient: self.user, actor: self.user, action: 'Bookings', notifiable: self, notification_template: template)
	    UserMailer.test_ride_booking(self, dealer_mail_template).deliver
	    UserMailer.testride_request_confirm(self, customer_mail_template).deliver
	  rescue StandardError => e
	  	logger.info "=======Test Booking Notification Error #{self.inspect}======"
	end	
end
