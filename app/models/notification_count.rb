class NotificationCount < ActiveRecord::Base
	belongs_to :user

	def self.add_notification_count(template)
		case template
		when 'Service Booking Notification'
			service_count += 1
		when 'Test Drive Notification'
			test_drive_count += 1
		when 'Insurance Renewal Notification'
			insurance_count += 1
		end
		self.save!		
	end
end
