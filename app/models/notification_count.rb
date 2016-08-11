class NotificationCount < ActiveRecord::Base
	belongs_to :user

	def add_notification_count(template)
		case template
		when 'Bookings'
			self.bookings += 1
			self.count += 1
		when 'Offer'
			self.offer += 1
			self.count += 1
		when 'Accessories'
			self.accessories += 1
			self.count +=1
		when 'Events'
			self.events +=1
			self.count +=1	
		end
		self.save!		
	end

	def reset_count_for_category(action)
		case action
		when 'Bookings'
			self.count -= self.bookings
			self.bookings = 0
		when 'Offer'
			self.count -= self.offer
			self.offer = 0
		when 'Accessories'
			self.count -= self.accessories
			self.accessories = 0
		when 'Events'
			self.count -= self.events	
			self.events = 0
		end
		self.save!	
	end	
end
