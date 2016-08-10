class UserEvent < ActiveRecord::Base
	belongs_to :event
	belongs_to :user

	def event_date
		self.event.try(:event_date)
	end
	def event_time
		self.event.try(:event_time)
	end
	def location
		self.event.try(:location)
	end
	def title
		self.event.try(:title)
	end
	def description
		self.event.try(:description)
	end
	

	def as_json(options={})
		super(:only => [:id, :user_id, :event_id, :perticipate_event, :user_event_date]).merge({:title => title, :event_date => event_date, :event_time => event_time, :assembly_lacation => location, :description => description})
	end
end
