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

	def reset_count_for_category(action)
		case action
		when 'Service booking notification', 'Service booking update notification', 'Service booking delete notification', 'Service reminder notification based on number of kms', 'Service in-app reminder notification'
			self.count -= self.service_count
			self.service_count = 0
		when 'Test drive notification', 'Test drive update notification', 'Test drive delete notification'
			self.count -= self.test_drive_count
			self.test_drive_count = 0
		when 'Insurance renewal notification'
			self.count -= self.insurance_count
			self.insurance_count = 0
		end
		self.save!	
	end	
end
