class NotificationCount < ActiveRecord::Base
	belongs_to :user

	def add_notification_count(template)
		case template
		when 'Service booking notification', 'Service booking update notification', 'Service booking delete notification', 'Service reminder notification based on number of kms', 'Service in-app reminder notification'
			self.service_count += 1
			self.count += 1
		when 'Test drive notification', 'Test drive update notification', 'Test drive delete notification'
			self.test_drive_count += 1
			self.count += 1
		when 'Insurance renewal notification'
			self.insurance_count += 1
			self.count +=1
		end
		self.save!		
	end
end
