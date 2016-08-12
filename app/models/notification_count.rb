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
		self.save		
	end

	def reset_count_for_category(action)
		case action
		when 'Bookings'
			c = self.count - self.bookings
			self.update_attribute(:count, c)
			self.update_attribute(:bookings, 0)
		when 'Offer'
			c = self.count - self.offer
			self.update_attribute(:count, c)
			self.update_attribute(:offer, 0)
		when 'Accessories'
			c = self.count - self.accessories
			self.update_attribute(:count, c)
			self.update_attribute(:accessories, 0)
		when 'Events'
			c = self.count - self.events
			self.update_attribute(:count, c)
			self.update_attribute(:events, 0)
		end
			
	end	
end
